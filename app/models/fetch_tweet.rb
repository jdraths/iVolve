#This MODEL NEEDS DATABASE WORK.  How can we organize all twitter methods to fill one database?
#All Twitter methods may pull different information... may not work with only one database!

class FetchTweet < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('tweet_id DESC') }
# NEED STRONG PARAMS SET UP IN CONTROLLER!
#require 'twitter'


# will need to iterate through each user.
# heroku says since_id paramater is invalid... since_id: maximum(:tweet_id)
	def self.pull_user_timeline(user)
		@twitter_auth = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => @twitter_auth.oauth_token, :oauth_token_secret => @twitter_auth.oauth_secret)
		twitter_client.user_timeline(@twitter_auth.screen_name, count: 200).each do |tweet|
			#unless exists?(tweet_id: tweet.id)
			if !tweet.urls.nil?
				tweet.urls.each do |entity| 
					@url = entity['url'].to_s
				end
			end
			if !tweet.geo.nil?
				tweet.geo.each do |entity|
					@geo = entity['coordinates'].to_s
				end
			end
			if !tweet.hashtags.nil?
				tweet.hashtags.each do |entity|
					@hashtags = entity['text'].to_s
				end
			end
			if !tweet.media.nil?
				tweet.media.each do |entity|
					@media = entity['photo']['url'].to_s
				end
			end
			if !tweet.metadata.nil?
				tweet.metadata.each do |entity|
					@metadata = entity['result_type'].to_s
				end
			end
			if !tweet.place.nil?
				tweet.place.each do |entity|
					@place_attributes = entity['attributes'].to_s
					@place_country = entity['country'].to_s
					@place_full_name = entity['place_full_name'].to_s
					@place_url = entity['place_url'].to_s
					@place_type = entity['type'].to_s
				end
			end
			if !tweet.symbols.nil?
				tweet.symbols.each do |entity|
					@symbol_text = entity['text'].to_s
				end
			end
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					# the following need a migration:
					from_user_id: tweet.from_user_id,
					from_user_name: tweet.from_user_name,
					in_reply_to_attrs_id: tweet.in_reply_to_attrs_id,
					# in_reply_to_screen_name is a string of original author's screen_name
					in_reply_to_screen_name: tweet.in_reply_to_screen_name,
					# in_reply_to_status_id is a string, will contain the original Tweet's ID
					in_reply_to_status_id_str: tweet.in_reply_to_status_id,
					# in_reply_to_user_id is a string, if the tweet is a reply this feild contaings the author id
					in_reply_to_user_id_str: tweet.in_reply_to_user_id,
					# lang is a string representation (BCP 47) of language
					lang: tweet.lang,
					repliers: tweet.repliers,
					# repliers_count is an integer
					repliers_count: tweet.repliers_count,
					# retweeted is boolean
					retweeted: tweet.retweeted,
					retweeters: tweet.retweeters,
					source: tweet.source,
					to_user: tweet.to_user,
					to_user_id: tweet.to_user_id,
					to_user_name: tweet.to_user_name,
					geo: @geo,
					# Arrays don't work in Active Record?
					#geo_array: tweet.geo{coordinates},
					# hashtags and media are arrays... issue: Can't convert array to string
					hashtags: @hashtags,
					#hashtags_array: tweet.hashtags{text},
					media: @media,
					#media_array: tweet.media{photo.expanded_url},
					metadata: @metadata,
					place_attributes: @place_attributes,
					place_country: @place_country,
					place_full_name: @place_full_name,
					place_url: @place_url,
					# place_type is a string
					place_type: @place_type,
					# symbols and url are arrays... issue: Can't convert array to string
					symbols: @symbol_text,
					#symbols_array: tweet.symbols{text},
					incl_url: @url,
					#incl_url_array: tweet.urls{expanded_url}
					)
			#end
		end
	end

# The mentions_timeline method does not allow a parameter for user name.  It simply returns the mentions
# timeline for the authenticating user...
	def self.pull_mentions_timeline(user)
		@twitter_auth = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => @twitter_auth.oauth_token, :oauth_token_secret => @twitter_auth.oauth_secret)
		twitter_client.mentions_timeline(count: @count, since_id: maximum(:tweet_id)).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					# the following need a migration:
					from_user_id: tweet.from_user_id,
					from_user_name: tweet.from_user_name,
					in_reply_to_attrs_id: tweet.in_reply_to_attrs_id,
					# in_reply_to_screen_name is a string of original author's screen_name
					in_reply_to_screen_name: tweet.in_reply_to_screen_name,
					# in_reply_to_status_id is a string, will contain the original Tweet's ID
					in_reply_to_status_id_str: tweet.in_reply_to_status_id,
					# in_reply_to_user_id is a string, if the tweet is a reply this feild contaings the author id
					in_reply_to_user_id_str: tweet.in_reply_to_user_id,
					# lang is a string representation (BCP 47) of language
					lang: tweet.lang,
					repliers: tweet.repliers,
					# repliers_count is an integer
					repliers_count: tweet.repliers_count,
					# retweeted is boolean
					retweeted: tweet.retweeted,
					retweeters: tweet.retweeters,
					source: tweet.source,
					to_user: tweet.to_user,
					to_user_id: tweet.to_user_id,
					to_user_name: tweet.to_user_name,
					geo: tweet.geo{coordinates}.to_s,
					# Arrays don't work in Active Record?
					#geo_array: tweet.geo{coordinates},
					# hashtags and media are arrays... issue: Can't convert array to string
					hashtags: tweet.hashtags{text}.to_s,
					#hashtags_array: tweet.hashtags{text},
					media: tweet.media{photo.expanded_url}.to_s,
					#media_array: tweet.media{photo.expanded_url},
					metadata: tweet.metadata{result_type},
					place_attributes: tweet.place{attributes},
					place_country: tweet.place{country},
					place_full_name: tweet.place{place_full_name},
					place_url: tweet.place{url},
					# place_type is a string
					place_type: tweet.place{type},
					symbols: tweet.symbols{text}.to_s,
					incl_url: @url,
					)
			end
		end
	end

# need to fix since id , before id...
	def self.manual_user_timeline
		Twitter.user_timeline("packyryan", count: 1, max_id: 372154667318251520, include_entities: 1).each do |tweet|
			# Add column for tweets.created_at (sent_at)...
			#unless exists?(tweet_id: tweet.id)
			tweet.urls.each do |entity| 
				@url = entity['url'].to_s
			end
				create!(
					# tweet_id is a 64 bit integer
					# tweet.id should be replaced with tweet.id_str (the string version)
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					# favorite_count is an integer, but I'm saving it as a string
					favorite_count: tweet.favorite_count,
					# retweet_count is an integer, but I'm saving it as a string
					retweet_count: tweet.retweet_count,
					# the following needs migration:
					from_user_id: tweet.from_user_id,
					from_user_name: tweet.from_user_name,
					in_reply_to_attrs_id: tweet.in_reply_to_attrs_id,
					# in_reply_to_screen_name is a string of original author's screen_name
					in_reply_to_screen_name: tweet.in_reply_to_screen_name,
					# in_reply_to_status_id is a string, will contain the original Tweet's ID
					in_reply_to_status_id_str: tweet.in_reply_to_status_id,
					# in_reply_to_user_id is a string, if the tweet is a reply this feild contaings the author id
					in_reply_to_user_id_str: tweet.in_reply_to_user_id,
					# lang is a string representation (BCP 47) of language
					lang: tweet.lang,
					repliers: tweet.repliers,
					# repliers_count is an integer
					repliers_count: tweet.repliers_count,
					# retweeted is boolean
					retweeted: tweet.retweeted,
					retweeters: tweet.retweeters,
					source: tweet.source,
					to_user: tweet.to_user,
					to_user_id: tweet.to_user_id,
					to_user_name: tweet.to_user_name,
					geo: tweet.geo{coordinates}.to_s,
					# Arrays don't work in Active Record?
					#geo_array: tweet.geo{coordinates},
					# hashtags and media are arrays... issue: Can't convert array to string
					hashtags: tweet.hashtags{text}.to_s,
					#hashtags_array: tweet.hashtags{text},
					media: tweet.media{photo.expanded_url}.to_s,
					#media_array: tweet.media{photo.expanded_url},
					metadata: tweet.metadata{result_type},
					place_attributes: tweet.place{attributes},
					place_country: tweet.place{country},
					place_full_name: tweet.place{place_full_name},
					place_url: tweet.place{url},
					# place_type is a string
					place_type: tweet.place{type},
					symbols: tweet.symbols{text}.to_s,
					incl_url: @url
					)
			#end
		end
	end
# need to fix since id, before id
	def self.manual_mentions_timeline
		# Twitter client is instantiated for each user with token and secret
		# Mentions needs another column to show who the mention is about.
		Twitter.mentions_timeline(count: 20).each do |tweet|
			unless exists?(tweet_id: tweet.id)
				create!(
					tweet_id: tweet.id,
					content: tweet.text,
					screen_name: tweet.user.screen_name,
					favorite_count: tweet.favorite_count,
					retweet_count: tweet.retweet_count,
					# the following need a migration:
					from_user_id: tweet.from_user_id,
					from_user_name: tweet.from_user_name,
					in_reply_to_attrs_id: tweet.in_reply_to_attrs_id,
					# in_reply_to_screen_name is a string of original author's screen_name
					in_reply_to_screen_name: tweet.in_reply_to_screen_name,
					# in_reply_to_status_id is a string, will contain the original Tweet's ID
					in_reply_to_status_id_str: tweet.in_reply_to_status_id,
					# in_reply_to_user_id is a string, if the tweet is a reply this feild contaings the author id
					in_reply_to_user_id_str: tweet.in_reply_to_user_id,
					# lang is a string representation (BCP 47) of language
					lang: tweet.lang,
					repliers: tweet.repliers,
					# repliers_count is an integer
					repliers_count: tweet.repliers_count,
					# retweeted is boolean
					retweeted: tweet.retweeted,
					retweeters: tweet.retweeters,
					source: tweet.source,
					to_user: tweet.to_user,
					to_user_id: tweet.to_user_id,
					to_user_name: tweet.to_user_name,
					geo: tweet.geo{coordinates}.to_s,
					# Arrays don't work in Active Record?
					#geo_array: tweet.geo{coordinates},
					# hashtags and media are arrays... issue: Can't convert array to string
					hashtags: tweet.hashtags{text}.to_s,
					#hashtags_array: tweet.hashtags{text},
					media: tweet.media{photo.expanded_url}.to_s,
					#media_array: tweet.media{photo.expanded_url},
					metadata: tweet.metadata{result_type},
					place_attributes: tweet.place{attributes},
					place_country: tweet.place{country},
					place_full_name: tweet.place{place_full_name},
					place_url: tweet.place{url},
					# place_type is a string
					place_type: tweet.place{type},
					# symbols and url are arrays... issue: Can't convert array to string
					symbols: tweet.symbols{text}.to_s,
					#symbols_array: tweet.symbols{text},
					incl_url: tweet.urls{expanded_url}.to_s,
					#incl_url_array: tweet.urls{expanded_url}
					)
			end
		end
	end
end