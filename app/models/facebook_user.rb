class FacebookUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar
	
	def self.wellness_bar_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends + int_likes + int_statuses + int_subscribers + int_subscribed_to) as social,
			 sum(int_achievements + int_posts) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends + int_subscribers + int_subscribed_to) as connections,
			 sum(int_achievements + int_posts + int_likes) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		# the next line checks for all users created between the start of today and end of today in CST.
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends) as int_friends, sum(int_likes) as int_likes, sum(int_posts) as int_posts, sum(int_statuses) as int_statuses")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		authorized = Authorization.find_by_user_id_and_provider(user, 'facebook')
		facebook = Koala::Facebook::API.new(authorized.oauth_token)
		if !facebook.get_connections('me', 'achievements').nil?
			num_achievements = facebook.get_connections('me', 'achievements').size
		end
		if !facebook.get_connections('me', 'subscribers').nil?
			num_subcribers = facebook.get_connections('me', 'subscribers').size
		end
		if !facebook.get_connections('me', 'subscribedto').nil?
			num_subscribed_to = facebook.get_connections('me', 'subscribedto').size
		end
		if !facebook.get_connections('me', 'statuses', limit: 9000).nil?
			num_statuses = facebook.get_connections('me', 'statuses', limit: 9000).size
		end
		if !facebook.get_connections('me', 'posts', limit: 9000).nil?
			num_posts = facebook.get_connections('me', 'posts', limit: 9000).size
		end
		if !facebook.get_connections('me', 'likes', limit: 9000).nil?
			num_likes = facebook.get_connections('me', 'likes', limit: 9000).size
		end
		if !facebook.get_connections('me', 'friends').nil?
			num_friends = facebook.get_connections('me', 'friends').size
		end
		facebook.get_object('me') do |data|
			create!(
			uid: data['id'],
			name: data['name'],
			first_name: data['first_name'],
			middle_name: data['middle_name'],
			last_name: data['last_name'],
			gender: data['gender'],
			# locale is a string containing the ISO Language Code and ISO Country Code
			locale: data['locale'],
			# languages is an array containing lanuage id and name
			languages: data['languages'].to_s,
			profile_url: data['link'],
			screen_name: data['username'],
			third_party_id: data['third_party_id'],
			installed: data['installed'],
			timezone: data['timezone'],
			updated_time: data['updated_time'],
			verified: data['verified'],
			bio: data['bio'],
			birthday: data['birthday'],
			cover_photo: data['cover'].to_s,
			currency: data['currency'].to_s,
			devices: data['devices'].to_s,
			education: data['education'].to_s,
			email: data['email'],
			hometown: data['hometown'].to_s,
			interested_in: data['interested_in'].to_s,
			location: data['location'].to_s,
			political: data['political'],
			favorite_athletes: data['favorite_athletes'].to_s,
			favorite_teams: data['favorite_teams'].to_s,
			profile_pic: data['picture'].to_s,
			quotes: data['quotes'],
			relationship_status: data['relationship_status'],
			religion: data['religion'],
			significant_other: data['significant_other'].to_s,
			website: data['website'],
			work: data['work'].to_s,
			num_achievements: num_achievements,
			int_achievements: num_achievements,
			#figure out a way to sum all the app_scores
			  # app_scores: facebook.get_connections('me', 'scores') { |data| data['score'] }
			num_subcribers: num_subcribers,
			int_subscribers: num_subcribers,
			num_subscribed_to: num_subscribed_to,
			int_subscribed_to: num_subscribed_to,
			num_statuses: num_statuses,
			int_statuses: num_statuses,
			num_posts: num_posts,
			int_posts: num_posts,
			num_likes: num_likes,
			int_likes: num_likes,
			num_friends: num_friends,
			int_friends: num_friends
			)
		end
	end

	def self.sched_user_data
		# facebook_sched could be a scope?
		facebook_sched = Authorization.where(provider: 'facebook') 
		# is there a better way to run the following method once we have 1000s of facebook auths??
		facebook_sched.each do |facebook_sched|
			begin
				FacebookUser.pull_user_data(facebook_sched.user)
			rescue Koala::Facebook::BadFacebookResponse
				logger.error "Koala::Facebook::BadFacebookResponse"
			rescue Koala::Facebook::ServerError
				logger.error "Koala::Facebook::ServerError"
			rescue Koala::Facebook::AuthenticationError
				logger.error "Koala::Facebook::AuthenticationError"
				logger.info "saving expired_token = true"
				facebook_sched.expired_token = true
				facebook_sched.save!
				logger.info "moving to next user..."
				# Could add a method here to save "NEEDS RE-AUTH" on user, so that user is forced to re-auth on next sign-in"
				next
			end
		end
	end
end
