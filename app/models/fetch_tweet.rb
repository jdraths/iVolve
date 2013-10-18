#This MODEL NEEDS DATABASE WORK.  How can we organize all twitter methods to fill one database?
#All Twitter methods may pull different information... may not work with only one database!

class FetchTweet < ActiveRecord::Base
# NEED STRONG PARAMS SET UP IN CONTROLLER!
#require 'twitter'


# will need to iterate through each user.
# heroku says since_id paramater is invalid... since_id: maximum(:tweet_id)
	def self.pull_user_timeline(user)
		@twitter_user = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => @twitter_user.oauth_token, :oauth_token_secret => @twitter_user.oauth_secret)
		twitter_client.user_timeline(@twitter_user.screen_name, count: 20).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					)
			end
		end
	end

# The mentions_timeline method does not allow a parameter for user name.  It simply returns the mentions
# timeline for the authenticating user...
	def self.pull_mentions_timeline(name, count)
		@name = name
		@count = count
#		a_user = Twitter.user(@name)
		Twitter.mentions_timeline(count: @count, since_id: maximum(:tweet_id)).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					)
			end
		end
	end

# need to fix since id , before id...
	def self.manual_user_timeline
		Twitter.user_timeline("packyryan", count: 20).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					)
			end
		end
	end
# need to fix since id, before id
	def self.manual_mentions_timeline
		a_user = Twitter.user("packyryan")
		Twitter.mentions_timeline(count: 20, since_id: maximum(:tweet_id)).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					)
			end
		end
	end
end