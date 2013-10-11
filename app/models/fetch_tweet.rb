#This MODEL NEEDS DATABASE WORK.  How can we organize all twitter methods to fill one database?
#All Twitter methods may pull different information... may not work with only one database!

class FetchTweet < ActiveRecord::Base!!
# NEED STRONG PARAMS SET UP IN CONTROLLER!
	def self.pull_favorites
		Twitter.favorites("roanedraths").each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					)
			end
		end
	end

#pull_user_timeline does not work yet.  It needs favorite_count and retweet_count in the database!
	def self.pull_user_timeline
		Twitter.user_timeline("roanedraths", count: 2).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					#the following columns need to be migrated to the database!!
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					)
			end
		end
	end
end