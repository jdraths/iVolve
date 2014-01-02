class InstagramUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_followers + int_following + int_likes_out) as social,
			 sum(int_media) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_followers + int_following) as connections,
			 sum(int_media + int_likes_out) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_followers) as int_followers, sum(int_following) as int_following, sum(int_media) as int_media, sum(int_likes_out) as int_likes_out")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		authorized = Authorization.find_by_user_id_and_provider(user, 'instagram')
		instagram = Instagram.client(access_token: authorized.oauth_token)
		current_instagram_user = InstagramUser.find_by_uid(authorized.uid)
		user_data = instagram.user
		total_likes_array = Array.new
		current_max_liked_id = current_instagram_user.max_liked_id
		# current_max_liked_id is the max_liked_id from the last DB entry.
		if !current_max_liked_id.nil?
			liked_recent = instagram.user_liked_media # needs to run until current_max_liked_id
			if !liked_recent.empty?
				if current_max_liked_id.to_i <= liked_recent.first.id.to_i
					liked_first_max_id = liked_recent.first.id
				else
					liked_first_max_id = current_max_liked_id
				end
				liked_recent_max_id = liked_first_max_id # this is the highest like id available in the API request.
				until current_max_liked_id.to_i >= liked_recent_max_id.to_i
					liked_recent.each do |x|
						if current_max_liked_id.to_i < x.id.to_i
							total_likes_array.push(x.id)
						elsif current_max_liked_id.to_i >= x.id.to_i
							break
						end
					end
					liked_recent_max_id = liked_recent.pagination.next_max_like_id
					liked_recent = instagram.user_liked_media(max_like_id: liked_recent_max_id)
				end
				num_likes_out = total_likes_array.size + current_instagram_user.int_likes_out
			end
		else
			liked_first = instagram.user_liked_media
			if liked_first.empty?
				num_likes_out = 0
				liked_first_max_id = nil
			else #!liked_first.nil?
				total_likes_array.push(liked_first.size)
				liked_first_max_id = liked_first.first.id
				liked_next_max_id = liked_first.pagination.next_max_like_id
				while !liked_next_max_id.nil?
					liked_next = instagram.user_liked_media(max_like_id: liked_next_max_id)
					total_likes_array.push(liked_next.size)
					liked_next_max_id = liked_next.pagination.next_max_like_id
				end
				num_likes_out = total_likes_array.size
			end
		end
		today = InstagramUser.where("uid = ? AND created_at >=?", authorized.uid, Time.zone.now.beginning_of_day).limit(1)[0]
		if !today.nil?
			today.update(
				full_name: user_data.full_name,
				username: user_data.username,
				bio: user_data.bio,
				uid: user_data.id,
				profile_picture: user_data.profile_picture,
				website: user_data.website,
				num_followers: user_data.counts.followed_by,
				int_followers: user_data.counts.followed_by,
				num_following: user_data.counts.follows,
				int_following: user_data.counts.follows,
				num_media: user_data.counts.media,
				int_media: user_data.counts.media,
				num_likes_out: num_likes_out,
				int_likes_out: num_likes_out,
				max_liked_id: liked_first_max_id,
			)
		else
			create!(
				full_name: user_data.full_name,
				username: user_data.username,
				bio: user_data.bio,
				uid: user_data.id,
				profile_picture: user_data.profile_picture,
				website: user_data.website,
				num_followers: user_data.counts.followed_by,
				int_followers: user_data.counts.followed_by,
				num_following: user_data.counts.follows,
				int_following: user_data.counts.follows,
				num_media: user_data.counts.media,
				int_media: user_data.counts.media,
				num_likes_out: num_likes_out,
				int_likes_out: num_likes_out,
				max_liked_id: liked_first_max_id,
			)
		end
	end

	def self.sched_user_data
		instagram_sched = Authorization.where(provider: 'instagram')
		instagram_sched.each do |instagram_sched|
			InstagramUser.pull_user_data(instagram_sched.user)
		end
	end
end
