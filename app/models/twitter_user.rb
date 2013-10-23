class TwitterUser < ActiveRecord::Base
	def self.pull_user_data(user)
		@authorized = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => @twitter_user.oauth_token, :oauth_token_secret => @twitter_user.oauth_secret)
		twitter_client.user(@authorized.screen_name) do |twitter_user|
			#unless exists?(uid: t_user.id)
			# could use unless exists? create! and then when exists? save!,
			# but that would not allow ivolve to track user changes over time.
				create!(
					name: twitter_user.screen_name,
					user_id: user,
					connections: twitter_user.connections,
					contributors_enabled: twitter_user.contributer_enabled,
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
					status: twitter_user.status,

					)
			#end
		end
	end

	def self.manual_user_data
		twitter_user = Twitter.user("whomikereilly")
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
end
