module GraphHelper

	def wellness_bar_over_time
		# This is missing facebook_subscribers, facebook_subscribed_to
		# Use @twitter_auth_user from sessions helper
		# The below data_by_day methods are a hash with the key = date
		# twitter_data_by_day[Date.today] returns a single entry array
		# twitter_data_by_day[Date.today].first is accessible via .method = to the methods in TwitterUser.total_grouped_by_date
		# accessible methods are .social, .creative, .physical
		@twitter_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "twitter")
		if !@twitter_graph.nil?
			@twitter_graph_user = TwitterUser.where("uid = ?", @twitter_graph.first['uid'])
			if !@twitter_graph_user.nil?
				twitter_data_by_day = @twitter_graph_user.wellness_bar_by_date(2.weeks.ago)
			end
		end

		@facebook_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "facebook")
		if !@facebook_graph.nil?
			@facebook_graph_user = FacebookUser.where("uid = ?", @facebook_graph.first['uid'])
			if !@facebook_graph_user.nil?
				facebook_data_by_day = @facebook_graph_user.wellness_bar_by_date(2.weeks.ago)
			end
		end

		@instagram_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "instagram")
		if !@instagram_graph.nil?
			@instagram_graph_user = InstagramUser.where("uid = ?", @instagram_graph.first['uid'])
			if !@instagram_graph_user.nil?
				instagram_data_by_day = @instagram_graph_user.wellness_bar_by_date(2.weeks.ago)
			end
		end

		@foursquare_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "foursquare")
		if !@foursquare_graph.nil?
			@foursquare_graph_user = FoursquareUser.where("uid = ?", @foursquare_graph.first['uid'])
			if !@foursquare_graph_user.nil?
				foursquare_data_by_day = @foursquare_graph_user.wellness_bar_by_date(2.weeks.ago)
			end
		end

		@fitbit_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "fitbit")
		if !@fitbit_graph.nil?
			@fitbit_graph_user = FitbitUser.where("encoded_id = ?", @fitbit_graph.first['uid'])
			if !@fitbit_graph_user.nil?
				fitbit_data_by_day = @fitbit_graph_user.wellness_bar_by_date(2.weeks.ago)
			end
		end
		(2.weeks.ago.to_date..Date.today).map do |date|
			created_at = date
			if !twitter_data_by_day.nil?
				if !twitter_data_by_day[date].nil?
					twitter_social = twitter_data_by_day[date].first.try(:social)
					twitter_creative = twitter_data_by_day[date].first.try(:creative)
				else
					twitter_social = 0
					twitter_creative = 0
				end
			end
			if !facebook_data_by_day.nil?
				if !facebook_data_by_day[date].nil?
					facebook_social = facebook_data_by_day[date].first.try(:social)
					facebook_creative = facebook_data_by_day[date].first.try(:creative)
				else
					facebook_social = 0
					facebook_creative = 0
				end
			end
			if !instagram_data_by_day.nil?
				if !instagram_data_by_day[date].nil?
					instagram_social = instagram_data_by_day[date].first.try(:social)
					instagram_creative = instagram_data_by_day[date].first.try(:creative)
				else
					instagram_social = 0
					instagram_creative = 0
				end
			end
			if !foursquare_data_by_day.nil?
				if !foursquare_data_by_day[date].nil?
					foursquare_social = foursquare_data_by_day[date].first.try(:social)
					foursquare_creative = foursquare_data_by_day[date].first.try(:creative)
				else
					foursquare_social = 0
					foursquare_creative = 0
				end
			end
			if !fitbit_data_by_day.nil?
				if !fitbit_data_by_day[date].nil?
					fitbit_physical = fitbit_data_by_day[date].first.try(:physical)
				else
					fitbit_physical = 0
				end
			end

			{
				created_at: date,
				social: twitter_social + facebook_social + instagram_social + foursquare_social,
				creative: twitter_creative + facebook_creative + instagram_creative + foursquare_creative,
				physical: fitbit_physical,
			}
		end
	end

	def twitter_user_data
		# IT WOULD BE NICE TO RE-FACTOR THIS SO IT IS THE SAME current_user as for other stats display...
		@twitter_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "twitter")
		@twitter_graph_user = TwitterUser.where("uid = ?", @twitter_graph.first['uid'])
		data_by_day = @twitter_graph_user.total_grouped_by_date(2.weeks.ago)
		#twitter_index_by_day = IvolveIndex.twitter_grouped_by_day(2.weeks.ago)
		(2.weeks.ago.to_date..Date.today).map do |date|
			if !data_by_day[date].nil?
				created_at = date
				friends_count = data_by_day[date].first.try(:friends_int_count)
				followers_count = data_by_day[date].first.try(:followers_int_count)
				tweets_count = data_by_day[date].first.try(:tweet_int_count)
				favd_count = data_by_day[date].first.try(:favorite_int_count)
				list_count = data_by_day[date].first.try(:listed_int_count)
			else
				created_at = date
				friends_count = 0
				followers_count = 0
				tweets_count = 0
				favd_count = 0
				list_count = 0
			end

			{
				created_at: date,
				num_friends: friends_count,
				#index_friends: twitter_index_friends,
				num_followers: followers_count,
				#index_followers: twitter_index_followers,
				tweets_sent: tweets_count,
				#index_sent: twitter_index_sent,
				tweets_favd: favd_count,
				#index_favd: twitter_index_favd,
				num_lists: list_count,
				#index_lists: twitter_index_lists,
			}
		end
	end

	def facebook_user_data
		# IT WOULD BE NICE TO RE-FACTOR THIS SO IT IS THE SAME current_user as for other stats display...
		@facebook_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "facebook")
		@facebook_graph_user = FacebookUser.where("uid = ?", @facebook_graph.first['uid'])
		data_by_day = @facebook_graph_user.total_grouped_by_date(2.weeks.ago)
		#twitter_index_by_day = IvolveIndex.twitter_grouped_by_day(2.weeks.ago)
		(2.weeks.ago.to_date..Date.today).map do |date|
			if !data_by_day[date].nil?
				created_at = date
				friends_count = data_by_day[date].first.try(:int_friends)
				likes_count = data_by_day[date].first.try(:int_likes)
				posts_count = data_by_day[date].first.try(:int_posts)
				statuses_count = data_by_day[date].first.try(:int_statuses)
			else
				created_at = date
				friends_count = 0
				likes_count = 0
				posts_count = 0
				statuses_count = 0
			end

			{
				created_at: date,
				fb_friends: friends_count,
				fb_likes: likes_count,
				fb_posts: posts_count,
				fb_statuses: statuses_count,
			}
		end
	end

	def instagram_user_data
		# IT WOULD BE NICE TO RE-FACTOR THIS SO IT IS THE SAME current_user as for other stats display...
		@instagram_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "instagram")
		@instagram_graph_user = InstagramUser.where("uid = ?", @instagram_graph.first['uid'])
		data_by_day = @instagram_graph_user.total_grouped_by_date(2.weeks.ago)
		#twitter_index_by_day = IvolveIndex.twitter_grouped_by_day(2.weeks.ago)
		(2.weeks.ago.to_date..Date.today).map do |date|
			if !data_by_day[date].nil?
				created_at = date
				followers_count = data_by_day[date].first.try(:int_followers)
				following_count = data_by_day[date].first.try(:int_following)
				media_count = data_by_day[date].first.try(:int_media)
				likes_count = data_by_day[date].first.try(:int_likes_out)
			else
				created_at = date
				followers_count = 0
				following_count = 0
				media_count = 0
				likes_count = 0
			end

			{
				created_at: date,
				insta_followers: followers_count,
				insta_following: following_count,
				insta_media: media_count,
				insta_likes: likes_count,
			}
		end
	end

	def foursquare_user_data
		# IT WOULD BE NICE TO RE-FACTOR THIS SO IT IS THE SAME current_user as for other stats display...
		@foursquare_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "foursquare")
		@foursquare_graph_user = FoursquareUser.where("uid = ?", @foursquare_graph.first['uid'])
		data_by_day = @foursquare_graph_user.total_grouped_by_date(2.weeks.ago)
	
		(2.weeks.ago.to_date..Date.today).map do |date|
			if !data_by_day[date].nil?
				created_at = date
				friends_count = data_by_day[date].first.try(:friends_count)
				following_count = data_by_day[date].first.try(:following_count)
				checkins_count = data_by_day[date].first.try(:checkins_count)
				badges_count = data_by_day[date].first.try(:badges_count)
				mayor_count = data_by_day[date].first.try(:mayor_count)
				tips_count = data_by_day[date].first.try(:tips_count)
				photos_count = data_by_day[date].first.try(:photos_count)
			else
				created_at = date
				friends_count = 0
				following_count = 0
				checkins_count = 0
				badges_count = 0
				mayor_count = 0
				tips_count = 0
				photos = 0
			end

			{
				created_at: date,
				foursquare_friends: friends_count,
				foursquare_following: following_count,
				foursquare_checkins: checkins_count,
				foursquare_badges: badges_count,
				foursquare_mayor: mayor_count,
				foursquare_tips: tips_count,
				foursquare_photos: photos_count,
			}
		end
	end
end