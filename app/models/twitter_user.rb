class TwitterUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first

	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(favorite_int_count + friends_int_count + followers_int_count) as social,
			 sum(listed_int_count + tweet_int_count) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(followers_int_count + listed_int_count + friends_int_count) as connections,
			 sum(tweet_int_count + favorite_int_count) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(favorite_int_count) as favorite_int_count, sum(followers_int_count) as followers_int_count, sum(friends_int_count) as friends_int_count, sum(listed_int_count) as listed_int_count, sum(tweet_int_count) as tweet_int_count")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		twitter_auth = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => twitter_auth.oauth_token, :oauth_token_secret => twitter_auth.oauth_secret)
		twitter_user = twitter_client.user(twitter_auth.screen_name)
		user_id = user
			#unless exists?(uid: t_user.id)
			# could use unless exists? create! and then when exists? save!,
			# but that would not allow ivolve to track user changes over time.
				create!(
					name: twitter_user.screen_name,
					user_id: user_id,
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

	def self.sched_user_data
		# twitter_sched could be a scope?
		twitter_sched = Authorization.where(provider: 'twitter') 
		# is there a better way to run the following method once we have 1000s of twitter auths??
		twitter_sched.each do |twitter_sched|
			TwitterUser.pull_user_data(twitter_sched.user)
		end
	end
end
