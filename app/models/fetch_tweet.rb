#This MODEL NEEDS DATABASE WORK.  How can we organize all twitter methods to fill one database?
#All Twitter methods may pull different information... may not work with only one database!

class FetchTweet < ActiveRecord::Base
# NEED STRONG PARAMS SET UP IN CONTROLLER!

	def self.pull_user_timeline(name, count)
		@name = name
		@count = count
		Twitter.user_timeline(@name, count: @count, since_id: maximum(:tweet_id)).each do |tweet|
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
# a_user.Twitter.mentions_timeline... might work
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
end