module GraphHelper
	def twitter_user_data
		(2.weeks.ago.to_date..Date.today).map do |date|
			{
				event: date,
				num_friends: @twitter_auth_user.friends_int_count,
				num_followers: @twitter_auth_user.followers_int_count,
				tweets_sent: @twitter_auth_user.tweet_int_count,
				tweets_favd: @twitter_auth_user.favorite_int_count,
				num_lists: @twitter_auth_user.listed_int_count,
			}
		end
	end
end
