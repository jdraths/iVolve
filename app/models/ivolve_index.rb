class IvolveIndex < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }

# The following method is for graphs
	def self.twitter_grouped_by_day(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(iv_twitter_friends) as iv_twitter_friends,
		 sum(iv_twitter_follwers) as iv_twitter_follwers, sum(iv_twitter_tweets_sent) as iv_twitter_tweets_sent,
		  sum(iv_twitter_tweets_favd) as iv_twitter_tweets_favd, sum(iv_twitter_lists) as iv_twitter_lists")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.avg_stats(db, column)
		case db
			when 'twitter_db'
				database = @twitter_users 
				db_size = @twitter_num_users
			when 'facebook_db'
				database = @facebook_users
				db_size = @facebook_num_users
			when 'instagram_db'
				database = @instagram_users
				db_size = @instagram_num_users
			when 'fitbit_db'
				database = @fitbit_users
				db_size = @fitbit_num_users
		end
		database.sum(column)/db_size
	end
	
	def self.populate_data
		# The following 4 variables pull TODAY's database entires ONLY, which would equate to one entry per user!!
		@twitter_users = TwitterUser.where('created_at >= ?', TwitterUser.first.created_at.beginning_of_day)
		@facebook_users = FacebookUser.where('created_at >= ?', FacebookUser.first.created_at.beginning_of_day)
		@instagram_users = InstagramUser.where('created_at >= ?', InstagramUser.first.created_at.beginning_of_day)
		@fitbit_users = FitbitUser.where('created_at >= ?', FitbitUser.first.created_at.beginning_of_day)

# MOVE THESE SIZE METHODS INTO avg_stats if they aren't directly used in self.populate_data
		# The following 4 variables calculate the size Today's DBs, aka the Number of Users in each service
		@twitter_num_users = @twitter_users.size
		@facebook_num_users = @facebook_users.size
		@instagram_num_users = @instagram_users.size
		@fitbit_num_users = @fitbit_users.size
		# TWITTER STATS BELOW	
		@iv_twitter_friends = avg_stats('twitter_db', 'friends_int_count')	
		@iv_twitter_follwers = avg_stats('twitter_db', 'followers_int_count')
		@iv_twitter_tweets_sent = avg_stats('twitter_db', 'tweet_int_count')
		@iv_twitter_tweets_favd = avg_stats('twitter_db', 'favorite_int_count')
		@iv_twitter_lists = avg_stats('twitter_db', 'listed_int_count')
		# FACEBOOK STATS BELOW		
		@iv_facebook_friends = avg_stats('facebook_db', 'int_friends')
		@iv_facebook_likes_sent = avg_stats('facebook_db', 'int_likes')
		@iv_facebook_posts = avg_stats('facebook_db', 'int_posts')
		@iv_facebook_statuses = avg_stats('facebook_db', 'int_statuses')
		@iv_facebook_achievements = avg_stats('facebook_db', 'int_achievements')
		@iv_facebook_subscribers  = avg_stats('facebook_db', 'int_subscribers')
		@iv_facebook_subscribed_to_you  = avg_stats('facebook_db', 'int_subscribed_to')
		# INSTAGRAM STATS BELOW
		@iv_instagram_followers = avg_stats('instagram_db', 'int_followers')
		@iv_instagram_following = avg_stats('instagram_db', 'int_following')
		@iv_instagram_shared = avg_stats('instagram_db', 'int_media')
		@iv_instagram_likes_sent = avg_stats('instagram_db', 'int_likes_out')
		# FITBIT STATS BELOW
		@iv_fitbit_height = avg_stats('fitbit_db', 'height_int')
		@iv_fitbit_weight = avg_stats('fitbit_db', 'weight_int')
		@iv_fitbit_stride_length_run = avg_stats('fitbit_db', 'stride_length_run_int')
		@iv_fitbit_stride_length_walk = avg_stats('fitbit_db', 'stride_length_walk_int')
		@iv_fitbit_life_tot_active_score = avg_stats('fitbit_db', 'lifetime_tot_active_score_int')
		@iv_fitbit_best_tot_active_score = avg_stats('fitbit_db', 'best_tot_active_score_int')
		@iv_fitbit_life_tot_cal_out = avg_stats('fitbit_db', 'lifetime_tot_cal_out_int')
		@iv_fitbit_best_tot_cal_out = avg_stats('fitbit_db', 'best_tot_cal_out_int')
		@iv_fitbit_life_tot_dist = avg_stats('fitbit_db', 'lifetime_tot_dist_int')
		@iv_fitbit_best_tot_dist = avg_stats('fitbit_db', 'best_tot_dist_int')
		@iv_fitbit_life_tot_steps = avg_stats('fitbit_db', 'lifetime_tot_steps_int')
		@iv_fitbit_best_tot_steps = avg_stats('fitbit_db', 'best_tot_steps_int')

		create!(
			iv_total: nil,
			iv_physical: nil,
			iv_intellectual: nil,
			iv_social: nil,
			iv_spiritual: nil,
			iv_creative: nil,
			iv_emotional: nil,
			male_total: nil,
			male_physical: nil,
			male_intellectual: nil,
			male_social: nil,
			male_spiritual: nil,
			male_creative: nil,
			male_emotional: nil,
			female_total: nil,
			female_physical: nil,
			female_intellectual: nil,
			female_social: nil,
			female_spiritual: nil,
			female_creative: nil,
			female_emotional: nil,
			twitter_users_total: @twitter_num_users,
			facebook_users_total: @facebook_num_users,
			instagram_users_total: @instagram_num_users,
			fitbit_users_total: @fitbit_num_users,
			iv_twitter_friends: @iv_twitter_friends,
			iv_twitter_follwers: @iv_twitter_follwers,
			iv_twitter_tweets_sent: @iv_twitter_tweets_sent,
			iv_twitter_tweets_favd: @iv_twitter_tweets_favd,
			iv_twitter_lists: @iv_twitter_lists,
			iv_facebook_friends: @iv_facebook_friends,
			iv_facebook_likes_sent: @iv_facebook_likes_sent,
			iv_facebook_posts: @iv_facebook_posts,
			iv_facebook_statuses: @iv_facebook_statuses,
			iv_facebook_achievements: @iv_facebook_achievements,
			iv_facebook_subscribers: @iv_facebook_subscribers,
			iv_facebook_subscribed_to_you: @iv_facebook_subscribed_to_you,
			iv_instagram_followers: @iv_instagram_followers,
			iv_instagram_following: @iv_instagram_following,
			iv_instagram_shared: @iv_instagram_shared,
			iv_instagram_likes_sent: @iv_instagram_likes_sent,
			iv_fitbit_height: @iv_fitbit_height,
			iv_fitbit_weight: @iv_fitbit_weight,
			iv_fitbit_stride_length_run: @iv_fitbit_stride_length_run,
			iv_fitbit_stride_length_walk: @iv_fitbit_stride_length_walk,
			iv_fitbit_life_tot_active_score: @iv_fitbit_life_tot_active_score,
			iv_fitbit_best_tot_active_score: @iv_fitbit_best_tot_active_score,
			iv_fitbit_life_tot_cal_out: @iv_fitbit_life_tot_cal_out,
			iv_fitbit_best_tot_cal_out: @iv_fitbit_best_tot_cal_out,
			iv_fitbit_life_tot_dist: @iv_fitbit_life_tot_dist,
			iv_fitbit_best_tot_dist: @iv_fitbit_best_tot_dist,
			iv_fitbit_life_tot_steps: @iv_fitbit_life_tot_steps,
			iv_fitbit_best_tot_steps: @iv_fitbit_best_tot_steps,
		)
	end
end
