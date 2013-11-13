module GraphHelper
	def twitter_user_data
		# IT WOULD BE NICE TO RE-FACTOR THIS SO IT IS THE SAME current_user as for other stats display...
		@twitter_graph = Authorization.where("user_id = ?", current_user).where("provider = ?", "twitter")
		@twitter_graph_user = TwitterUser.where("uid = ?", @twitter_graph.first['uid'])
		data_by_day = @twitter_graph_user.total_grouped_by_date(2.weeks.ago)
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
				num_followers: followers_count,
				tweets_sent: tweets_count,
				tweets_favd: favd_count,
				num_lists: list_count,
			}
		end
	end
end
