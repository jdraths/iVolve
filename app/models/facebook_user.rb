class FacebookUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar
	
	def self.wellness_bar_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends + int_likes + int_statuses + int_subscribers + int_subscribed_to) as social,
			 sum(int_achievements + int_posts) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends + int_subscribers + int_subscribed_to) as connections,
			 sum(int_achievements + int_posts + int_likes) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		# the next line checks for all users created between the start of today and end of today in CST.  We also used the @time_now variable to subtract the UTC OFFSET... 
			# ...this was found as a solution for the issue where the graphs on the home page display the next day too early... what time of day do they display the next day?
		# 12/17/13 - JRD changed the next line so that it only looked for time up to current, not to the end of the current day.
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_friends) as int_friends, sum(int_likes) as int_likes, sum(int_posts) as int_posts, sum(int_statuses) as int_statuses")
		data.group_by { |d| d.created_at.to_date }
	end

	def facebook_exists_today?
		today = FacebookUser.where("uid = ? AND created_at >= ?", @authorized.uid, Time.zone.now.beginning_of_day).limit(1)
		today[0].nil?
	end

	def self.pull_user_data(user)
		@authorized = Authorization.find_by_user_id_and_provider(user, 'facebook')
		facebook = Koala::Facebook::API.new(@authorized.oauth_token)
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
		if !facebook.get_object('me').nil?
			facebook_me = facebook.get_object('me')
		end
		today = FacebookUser.where("uid = ? AND created_at >= ?", @authorized.uid, Time.zone.now.beginning_of_day).limit(1)[0]
		if !today.nil?
			logger.debug "facebook exists!"
			today.update(
				uid: facebook_me['id'],
				name: facebook_me['name'],
				first_name: facebook_me['first_name'],
				middle_name: facebook_me['middle_name'],
				last_name: facebook_me['last_name'],
				gender: facebook_me['gender'],
				# locale is a string containing the ISO Language Code and ISO Country Code
				locale: facebook_me['locale'],
				# languages is an array containing lanuage id and name
				languages: facebook_me['languages'].to_s,
				profile_url: facebook_me['link'],
				screen_name: facebook_me['username'],
				third_party_id: facebook_me['third_party_id'],
				installed: facebook_me['installed'],
				timezone: facebook_me['timezone'],
				updated_time: facebook_me['updated_time'],
				verified: facebook_me['verified'],
				bio: facebook_me['bio'],
				birthday: facebook_me['birthday'],
				cover_photo: facebook_me['cover'].to_s,
				currency: facebook_me['currency'].to_s,
				devices: facebook_me['devices'].to_s,
				education: facebook_me['education'].to_s,
				email: facebook_me['email'],
				hometown: facebook_me['hometown'].to_s,
				interested_in: facebook_me['interested_in'].to_s,
				location: facebook_me['location'].to_s,
				political: facebook_me['political'],
				favorite_athletes: facebook_me['favorite_athletes'].to_s,
				favorite_teams: facebook_me['favorite_teams'].to_s,
				profile_pic: facebook_me['picture'].to_s,
				quotes: facebook_me['quotes'],
				relationship_status: facebook_me['relationship_status'],
				religion: facebook_me['religion'],
				significant_other: facebook_me['significant_other'].to_s,
				website: facebook_me['website'],
				work: facebook_me['work'].to_s,
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
		else
		#if facebook_exists_today? == false
			logger.debug "facebook doesn't exist!"
			create!(
			uid: facebook_me['id'],
			name: facebook_me['name'],
			first_name: facebook_me['first_name'],
			middle_name: facebook_me['middle_name'],
			last_name: facebook_me['last_name'],
			gender: facebook_me['gender'],
			# locale is a string containing the ISO Language Code and ISO Country Code
			locale: facebook_me['locale'],
			# languages is an array containing lanuage id and name
			languages: facebook_me['languages'].to_s,
			profile_url: facebook_me['link'],
			screen_name: facebook_me['username'],
			third_party_id: facebook_me['third_party_id'],
			installed: facebook_me['installed'],
			timezone: facebook_me['timezone'],
			updated_time: facebook_me['updated_time'],
			verified: facebook_me['verified'],
			bio: facebook_me['bio'],
			birthday: facebook_me['birthday'],
			cover_photo: facebook_me['cover'].to_s,
			currency: facebook_me['currency'].to_s,
			devices: facebook_me['devices'].to_s,
			education: facebook_me['education'].to_s,
			email: facebook_me['email'],
			hometown: facebook_me['hometown'].to_s,
			interested_in: facebook_me['interested_in'].to_s,
			location: facebook_me['location'].to_s,
			political: facebook_me['political'],
			favorite_athletes: facebook_me['favorite_athletes'].to_s,
			favorite_teams: facebook_me['favorite_teams'].to_s,
			profile_pic: facebook_me['picture'].to_s,
			quotes: facebook_me['quotes'],
			relationship_status: facebook_me['relationship_status'],
			religion: facebook_me['religion'],
			significant_other: facebook_me['significant_other'].to_s,
			website: facebook_me['website'],
			work: facebook_me['work'].to_s,
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
			rescue Faraday::Error::ConnectionFailed => e
				Rollbar.report_message("Faraday::Error::ConnectionFailed", "error")
				Rollbar.report_exception(e)
				FacebookUser.repopulate_data
			rescue Faraday::Error::TimeoutError => e
				Rollbar.report_message("Faraday::Error::TimeoutError", "error")
				Rollbar.report_exception(e)
				FacebookUser.repopulate_data
			rescue Koala::Facebook::BadFacebookResponse => e
				Rollbar.report_message("Koala::Facebook::BadFacebookResponse", "error")
				Rollbar.report_exception(e)
				FacebookUser.repopulate_data
			rescue Koala::Facebook::ServerError => e
				Rollbar.report_message("Koala::Facebook::ServerError", "error")
				Rollbar.report_exception(e)
				FacebookUser.repopulate_data
			rescue Koala::Facebook::AuthenticationError => e
				Rollbar.report_message("Koala::Facebook::AuthenticationError", "error")
				Rollbar.report_exception(e)
				logger.info "saving expired_token = true"
				facebook_sched.expired_token = true
				facebook_sched.save!
				this_user = FacebookUser.find_by_uid(facebook_sched.uid)
				this_user.deauthed_facebook = true
				this_user.save!
				logger.info "moving to next user..."
				# Could add a method here to save "NEEDS RE-AUTH" on user, so that user is forced to re-auth on next sign-in"
				next
			end
		end
	end

### repopulate_data is used in ERROR RESCUES... ###
	def self.repopulate_data
		facebook_user = FacebookUser.find_by_uid(@authorized.uid)
		# the below code would be if we need to return the two most recent users...
		#facebook_users = FacebookUser.where("uid = ?", @authorized.uid).limit(2)
		create!(
			uid: facebook_user.uid,
			name: facebook_user.name,
			first_name: facebook_user.first_name,
			middle_name: facebook_user.middle_name,
			last_name: facebook_user.last_name,
			gender: facebook_user.gender,
			# locale is a string containing the ISO Language Code and ISO Country Code
			locale: facebook_user.locale,
			# languages is an array containing lanuage id and name
			languages: facebook_user.languages,
			profile_url: facebook_user.profile_url,
			screen_name: facebook_user.screen_name,
			third_party_id: facebook_user.third_party_id,
			installed: facebook_user.installed,
			timezone: facebook_user.timezone,
			updated_time: facebook_user.updated_time,
			verified: facebook_user.verified,
			bio: facebook_user.bio,
			birthday: facebook_user.birthday,
			cover_photo: facebook_user.cover_photo,
			currency: facebook_user.currency,
			devices: facebook_user.devices,
			education: facebook_user.education,
			email: facebook_user.email,
			hometown: facebook_user.hometown,
			interested_in: facebook_user.interested_in,
			location: facebook_user.location,
			political: facebook_user.political,
			favorite_athletes: facebook_user.favorite_athletes,
			favorite_teams: facebook_user.favorite_teams,
			profile_pic: facebook_user.profile_pic,
			quotes: facebook_user.quotes,
			relationship_status: facebook_user.relationship_status,
			religion: facebook_user.religion,
			significant_other: facebook_user.significant_other,
			website: facebook_user.website,
			work: facebook_user.work,
			num_achievements: facebook_user.num_achievements,
			int_achievements: facebook_user.num_achievements,
			#figure out a way to sum all the app_scores
			  # app_scores: facebook_user.facebook.get_connections('me', 'scores') { |data| data['score'] }
			num_subcribers: facebook_user.num_subcribers,
			int_subscribers: facebook_user.num_subcribers,
			num_subscribed_to: facebook_user.num_subscribed_to,
			int_subscribed_to: facebook_user.num_subscribed_to,
			num_statuses: facebook_user.num_statuses,
			int_statuses: facebook_user.num_statuses,
			num_posts: facebook_user.num_posts,
			int_posts: facebook_user.num_posts,
			num_likes: facebook_user.num_likes,
			int_likes: facebook_user.num_likes,
			num_friends: facebook_user.num_friends,
			int_friends: facebook_user.num_friends,
			failed_request: true,
			)
	end
end
