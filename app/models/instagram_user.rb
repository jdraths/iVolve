class InstagramUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.total_grouped_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(int_followers) as int_followers, sum(int_following) as int_following, sum(int_media) as int_media, sum(int_likes_out) as int_likes_out")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		authorized = Authorization.find_by_user_id_and_provider(user, 'instagram')
		instagram = Instagram.client(access_token: authorized.oauth_token)
		user_data = instagram.user
		liked = instagram.user_liked_media
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
			num_likes_out: liked.size,
			int_likes_out: liked.size,
			)
	end

	def self.sched_user_data
		instagram_sched = Authorization.where(provider: 'instagram')
		instagram_sched.each do |instagram_sched|
			InstagramUser.pull_user_data(instagram_sched.user)
		end
	end
end
