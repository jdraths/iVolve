module GraphHelper
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
