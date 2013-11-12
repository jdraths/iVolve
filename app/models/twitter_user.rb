class TwitterUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first

	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.total_grouped_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("created_at, favorite_int_count, followers_int_count, friends_int_count, listed_int_count, tweet_int_count")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		@twitter_auth = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => @twitter_auth.oauth_token, :oauth_token_secret => @twitter_auth.oauth_secret)
		twitter_user = twitter_client.user(@twitter_auth.screen_name)
		@user_id = user
			#unless exists?(uid: t_user.id)
			# could use unless exists? create! and then when exists? save!,
			# but that would not allow ivolve to track user changes over time.
				create!(
					name: twitter_user.screen_name,
					user_id: @user_id,
					connections: twitter_user.connections,
					contributors_enabled: twitter_user.contributors_enabled,
					default_profile: twitter_user.default_profile,
					default_profile_image: twitter_user.default_profile_image,
					description: twitter_user.description,
					favorite_count: twitter_user.favorite_count,
					favorite_int_count: twitter_user.favorite_count,
					follow_request_sent: twitter_user.follow_request_sent,
					followers_count: twitter_user.followers_count,
					followers_int_count: twitter_user.followers_count,
					friends_count: twitter_user.friends_count,
					friends_int_count: twitter_user.friends_count,
					geo_enabled: twitter_user.geo_enabled,
					is_translator: twitter_user.is_translator,
					lang: twitter_user.lang,
					listed_count: twitter_user.listed_count,
					listed_int_count: twitter_user.listed_count,
					location: twitter_user.location,
					notifications: twitter_user.notifications,
					protected_user: twitter_user.protected,
					uid: twitter_user.id,
					tweet_count: twitter_user.statuses_count,
					tweet_int_count: twitter_user.statuses_count,
					time_zone: twitter_user.time_zone,
					url: twitter_user.url,
					utc_offset: twitter_user.utc_offset,
					verified: twitter_user.verified,
					description_urls: twitter_user.description_urls.to_s,
					status: twitter_user.status.to_s,
					)
			#end
	end

	def self.manual_user_data
		twitter_user = Twitter.user("roanedraths")
			#unless exists?(uid: t_user.id)
			# could use unless exists? create! and then when exists? save!,
			# but that would not allow ivolve to track user changes over time.
				create!(
					name: twitter_user.screen_name,
					#user_id: Authorization.find_by_provider_and_screen_name('twitter', 'whomikereilly'),
					connections: twitter_user.connections,
					contributors_enabled: twitter_user.contributors_enabled,
					default_profile: twitter_user.default_profile,
					default_profile_image: twitter_user.default_profile_image,
					description: twitter_user.description,
					favorite_count: twitter_user.favorite_count,
					follow_request_sent: twitter_user.follow_request_sent,
					followers_count: twitter_user.followers_count,
					friends_count: twitter_user.friends_count,
					geo_enabled: twitter_user.geo_enabled,
					is_translator: twitter_user.is_translator,
					lang: twitter_user.lang,
					listed_count: twitter_user.listed_count,
					location: twitter_user.location,
					notifications: twitter_user.notifications,
					protected_user: twitter_user.protected,
					uid: twitter_user.id,
					tweet_count: twitter_user.statuses_count,
					time_zone: twitter_user.time_zone,
					url: twitter_user.url,
					utc_offset: twitter_user.utc_offset,
					verified: twitter_user.verified,
					description_urls: twitter_user.description_urls.to_s,
					status: twitter_user.status.to_s,

					)
			#end
		#end
	end

	def self.sched_user_data
		# twitter_sched could be a scope?
		twitter_sched = Authorization.where(provider: 'twitter') 
		# is there a better way to run the following method once we have 1000s of twitter auths??
		twitter_sched.each do |twitter_sched|
			TwitterUser.pull_user_data(twitter_sched.user)
		end
	end
end
