class TwitterUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first

	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(favorite_int_count + friends_int_count + followers_int_count) as social,
			 sum(listed_int_count + tweet_int_count) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(followers_int_count + listed_int_count + friends_int_count) as connections,
			 sum(tweet_int_count + favorite_int_count) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(favorite_int_count) as favorite_int_count, sum(followers_int_count) as followers_int_count, sum(friends_int_count) as friends_int_count, sum(listed_int_count) as listed_int_count, sum(tweet_int_count) as tweet_int_count")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		twitter_auth = Authorization.find_by_user_id_and_provider(user, 'twitter')
		twitter_client = Twitter::Client.new(:oauth_token => twitter_auth.oauth_token, :oauth_token_secret => twitter_auth.oauth_secret)
		twitter_user = twitter_client.user(twitter_auth.screen_name)
		user_id = twitter_auth.user_id
		current_twitter_user = TwitterUser.find_by_uid(twitter_auth.uid)
		# current_user_data is a 2 item array of the most recent TwitterUser entries for this uid.
		current_user_data = TwitterUser.where("uid = ?", twitter_auth.uid).limit(2)
		# if there were two previous TwitterUsers for this uid, perform the following...
		if !current_user_data.blank?
			# initialize an empty hash for retweets_of_me
			# the retweets_of_me_hash is used in !max_retweets_existing_one.nil? else max_retweets_existing_one.nil?
			retweets_of_me_hash = Hash.new
			if !current_user_data.first.nil?
				# did TwitterUser's last entry include re-tweets?
				max_retweets_existing_one = current_user_data.first.max_retweets_of_me
			else
				# if there is no previous current_user_data, then ther is no max_retweets_existing_two...
				max_retweets_existing_one = nil
			end
			if !current_user_data.last.nil?
				# did TwitterUser's second-to-last entry include re-tweets?
				max_retweets_existing_two = current_user_data.last.max_retweets_of_me
			else
				# if there is no second-to-last current_user_data, then there is no max_retweets_existing_two...
				max_retweets_existing_two = nil
			end
			# if you had previous re-tweets check to see if the re-tweet count has gone up...
			if !max_retweets_existing_one.nil? && max_retweets_existing_two.nil?
				# first check for updated retweet counts for retweets before max_retweets_existing
				retweets_of_me_before = twitter_client.retweets_of_me(count: 200, max_id: max_retweets_existing_one, trim_user: true, include_entities: false, include_user_entities: false)
				if !retweets_of_me_before.blank?
					retweets_of_me_arr = Array.new
					retweets_of_me_before.each do |x|
						retweets_of_me_arr.push(x.retweet_count)
					end
					if retweets_of_me_arr.sum > current_twitter_user.num_retweets_of_me
						# update this TwitterUser with new number of retweets
						current_twitter_user.update(num_retweets_of_me: retweets_of_me_arr.sum)
					end
				end
			elsif !max_retweets_existing_one.nil? && !max_retweets_existing_two.nil?
				# only check for new retweets between the second-to-last retweet and the current retweet
				retweets_of_me_before = twitter_client.retweets_of_me(count: 200, since_id: max_retweets_existing_two, max_id: max_retweets_existing_one, trim_user: true, include_entities: false, include_user_entities: false)
				if !retweets_of_me_before.blank?
					retweets_of_me_arr = Array.new
					retweets_of_me_before.each do |x|
						retweets_of_me_arr.push(x.retweet_count)
					end
					if retweets_of_me_arr.sum > current_twitter_user.num_retweets_of_me
						# update this TwitterUser with new num retweets
						current_twitter_user.update(num_retweets_of_me: retweets_of_me_arr.sum)
					end
				end
			end
			# the following should perform if either of the above two IFs were valid...
			# the following checks for new retweets since the most recent retweet id...
			if !max_retweets_existing_one.nil?
				# go straight to checking if you have any new retweets...
				# check for retweets since the max_retweets_existing id
				retweets_of_me_since = twitter_client.retweets_of_me(count: 200, since_id: max_retweets_existing_one, trim_user: true, include_entities: false, include_user_entities: false)
				# since_id parameter excludes since_id in the api request
				if !retweets_of_me_since.blank?
					retweets_of_me_since.each do |x|
						retweets_of_me_hash[x.id] = x.retweet_count
					end
					# what is the maximum retweet_id returned in that request
					max_retweets_id = retweets_of_me_hash.keys.first
					# now perform new request to see if there are any more retweets since that max_retweets_id
					# in other words were there greater than 200 additional retweets since the last request?
					recent_retweets_of_me = twitter_client.retweets_of_me(count: 200, since_id: max_retweets_id, trim_user: true, include_entities: false, include_user_entities: false)
					if !recent_retweets_of_me.blank?
						# if the most recent retweet returned in the API request is greater than the previous... perform while...
						while recent_retweets_of_me.first.id != max_retweets_id
							recent_retweets_of_me.each do |x|
								retweets_of_me_hash[x.id] = x.retweet_count
							end
							max_retweets_id = retweets_of_me_hash.keys.first
							recent_retweets_of_me = twitter_client.retweets_of_me(count: 200, since_id: max_retweets_id, trim_user: true, include_entities: false, include_user_entities: false)
						end
					end
					# if there have been retweets since, save the new retweets plus the old num retweets.
					num_retweets_of_me = retweets_of_me_hash.values.sum + current_user_data.first.num_retweets_of_me
					max_retweets_of_me_id = max_retweets_id
				else
					# if there have been no new retweets of me since, re-save the previous retweet id and num retweets.
					num_retweets_of_me = current_user_data.first.num_retweets_of_me
					max_retweets_of_me_id = max_retweets_existing_one
				end
			# if there was no max_retweets_id in the most recent twitter user...
			else #if max_retweets_existing_one.nil? AKA if there were no retweets saved in the DB before
				# are there retweets of me before this request?
				retweets_of_me_before = twitter_client.retweets_of_me(count: 200, trim_user: true, include_entities: false, include_user_entities: false)
				if !retweets_of_me_before.blank?
					retweets_of_me_before.each do |x|
						# this builds the hash from most recent = first to oldest = last
						retweets_of_me_hash[x.id] = x.retweet_count
					end
					min_retweets_of_me = retweets_of_me_hash.keys.last
					# now run API request for retweets of me before the min id from the retweets_of_me_before request
					# in other words were there greater than 200 retweets before this retweet request?
					more_retweets_of_me = twitter_client.retweets_of_me(count: 200, max_id: min_retweets_of_me, trim_user: true, include_entities: false, include_user_entities: false)
					# max_id includes max_id in the API request
					if !more_retweets_of_me.blank?
						while more_retweets_of_me.last.id != min_retweets_of_me
							more_retweets_of_me.each do |x|
								retweets_of_me_hash[x.id] = x.retweet_count
							end
							min_retweets_of_me = retweets_of_me_hash.keys.last
							more_retweets_of_me = twitter_client.retweets_of_me(count: 200, max_id: min_retweets_of_me, trim_user: true, include_entities: false, include_user_entities: false)
						end
					end
					num_retweets_of_me = retweets_of_me_hash.values.sum
					# max retweets id should equal the highest retweet id saved in the has.
					max_retweets_of_me_id = retweets_of_me_hash.keys.first
				end
			end

			# initialize an empty array for retweets_by_me
			retweets_by_me_id_arr = Array.new
			if !current_twitter_user.nil?
				# did TwitterUser's last entry include retweets_by_me?
				max_retweets_by_me_existing = current_twitter_user.max_retweets_by_me
			else
				# if there is no previous current_user_data, then there is no max_retweets_by_me_existing...
				max_retweets_by_me_existing = nil
			end
			# the following checks for new retweets_by_me since the most recent mention id...
			if !max_retweets_by_me_existing.nil?
				# go straight to checking if you have any new retweets_by_me...
				# check for retweets_by_me since the max_retweets_by_me_existing id
				retweets_by_me_since = twitter_client.retweeted_by_me(count: 3200, since_id: max_retweets_by_me_existing, trim_user: true)
				# since_id parameter excludes since_id in the api request
				if !retweets_by_me_since.blank?
					retweets_by_me_since.each do |x|
						retweets_by_me_id_arr.push(x.id)
					end
					# what is the maximum retweets_by_me_id_id returned in that request
					max_retweets_by_me_id = retweets_by_me_id_arr.first
					# now perform new request to see if there are any more retweets_by_me since that max_retweets_by_me_id
					# in other words were there greater than 3200 additional retweets_by_me since the last request?
					recent_retweets_by_me = twitter_client.retweeted_by_me(count: 3200, since_id: max_retweets_by_me_id, trim_user: true)
					if !recent_retweets_by_me.blank?
						# if the most recent retweets_by_me_id returned in the API request is greater than the previous... perform while...
						while recent_retweets_by_me.first.id != max_retweets_by_me_id
							recent_retweets_by_me.each do |x|
								retweets_by_me_id_arr.push(x.id)
							end
							max_retweets_by_me_id = retweets_by_me_id_arr.first
							recent_retweets_by_me = twitter_client.retweeted_by_me(count: 3200, since_id: max_retweets_by_me_id, trim_user: true)
						end
					end
					# if there have been retweets_by_me since, save the new retweets_by_me plus the old num retweets_by_me.
					num_retweets_by_me = retweets_by_me_id_arr.size + current_twitter_user.num_retweets_by_me
					max_retweets_by_me_id = max_retweets_by_me_id
				else
					# if there have been no new retweets_by_me of me since, re-save the previous retweets_by_me_id id and num retweets_by_me.
					num_retweets_by_me = current_twitter_user.num_retweets_by_me
					max_retweets_by_me_id = max_retweets_by_me_existing
				end
			# if there was no max_retweets_by_me_id in the most recent twitter user...
			else #if max_retweets_by_me_existing.nil? AKA if there were no retweets_by_me saved in the DB before
				# are there retweets_by_me of me before this request?
				retweets_by_me_before = twitter_client.retweeted_by_me(count: 3200, trim_user: true)
				if !retweets_by_me_before.blank?
					retweets_by_me_before.each do |x|
						# this builds the hash from most recent = first to oldest = last
						retweets_by_me_id_arr.push(x.id)
					end
					min_retweets_by_me = retweets_by_me_id_arr.last
					# now run API request for retweets_by_me of me before the min id from the retweets_by_me_before request
					# in other words were there greater than 3200 retweets_by_me before this retweets_by_me_id request?
					more_retweets_by_me = twitter_client.retweeted_by_me(count: 3200, max_id: min_retweets_by_me, trim_user: true)
					# max_id includes max_id in the API request
					if !more_retweets_by_me.blank?
						while more_retweets_by_me.last.id != min_retweets_by_me
							more_retweets_by_me.each do |x|
								retweets_by_me_id_arr.push(x.id)
							end
							min_retweets_by_me = retweets_by_me_id_arr.last
							more_retweets_by_me = twitter_client.retweeted_by_me(count: 3200, max_id: min_retweets_by_me, trim_user: true)
						end
					end
					num_retweets_by_me = retweets_by_me_id_arr.size
					# max retweets_by_me id should equal the highest mention id saved in the has.
					max_retweets_by_me_id = retweets_by_me_id_arr.first
				end
			end			

			# initialize an empty array for mentions_of_me
			mentions_of_me_id_arr = Array.new
			if !current_twitter_user.nil?
				# did TwitterUser's last entry include mentions?
				max_mentions_existing = current_twitter_user.max_mentions_of_me
			else
				# if there is no previous current_twitter_user, then there is no max_mentions_existing...
				max_mentions_existing = nil
			end
			# the following checks for new mentions since the most recent mention id...
			if !max_mentions_existing.nil?
				# go straight to checking if you have any new mentions...
				# check for mentions since the max_mentions_existing id
				mentions_of_me_since = twitter_client.mentions_timeline(count: 800, since_id: max_mentions_existing, trim_user: true)
				# since_id parameter excludes since_id in the api request
				if !mentions_of_me_since.blank?
					mentions_of_me_since.each do |x|
						mentions_of_me_id_arr.push(x.id)
					end
					# what is the maximum mention_id returned in that request
					max_mentions_id = mentions_of_me_id_arr.first
					# now perform new request to see if there are any more mentions since that max_mentions_id
					# in other words were there greater than 800 additional mentions since the last request?
					recent_mentions_of_me = twitter_client.mentions_timeline(count: 800, since_id: max_mentions_id, trim_user: true)
					if !recent_mentions_of_me.blank?
						# if the most recent mention returned in the API request is greater than the previous... perform while...
						while recent_mentions_of_me.first.id != max_mentions_id
							recent_mentions_of_me.each do |x|
								mentions_of_me_id_arr.push(x.id)
							end
							max_mentions_id = mentions_of_me_id_arr.first
							recent_mentions_of_me = twitter_client.mentions_timeline(count: 800, since_id: max_mentions_id, trim_user: true)
						end
					end
					# if there have been mentions since, save the new mentions plus the old num mentions.
					num_mentions_of_me = mentions_of_me_id_arr.size + current_twitter_user.num_mentions_of_me
					max_mentions_of_me_id = max_mentions_id
				else
					# if there have been no new mentions of me since, re-save the previous mention id and num mentions.
					num_mentions_of_me = current_twitter_user.num_mentions_of_me
					max_mentions_of_me_id = max_mentions_existing
				end
			# if there was no max_mentions_id in the most recent twitter user...
			else #if max_mentions_existing.nil? AKA if there were no mentions saved in the DB before
				# are there mentions of me before this request?
				mentions_of_me_before = twitter_client.mentions_timeline(count: 800, trim_user: true)
				if !mentions_of_me_before.blank?
					mentions_of_me_before.each do |x|
						# this builds the hash from most recent = first to oldest = last
						mentions_of_me_id_arr.push(x.id)
					end
					min_mentions_of_me = mentions_of_me_id_arr.last
					# now run API request for mentions of me before the min id from the mentions_of_me_before request
					# in other words were there greater than 800 mentions before this mention request?
					more_mentions_of_me = twitter_client.mentions_timeline(count: 800, max_id: min_mentions_of_me, trim_user: true)
					# max_id includes max_id in the API request
					if !more_mentions_of_me.blank?
						while more_mentions_of_me.last.id != min_mentions_of_me
							more_mentions_of_me.each do |x|
								mentions_of_me_id_arr.push(x.id)
							end
							min_mentions_of_me = mentions_of_me_id_arr.last
							more_mentions_of_me = twitter_client.mentions_timeline(count: 800, max_id: min_mentions_of_me, trim_user: true)
						end
					end
					num_mentions_of_me = mentions_of_me_id_arr.size
					# max mentions id should equal the highest mention id saved in the has.
					max_mentions_of_me_id = mentions_of_me_id_arr.first
				end
			end
		end
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
			max_retweets_of_me: max_retweets_of_me_id,
			num_retweets_of_me: num_retweets_of_me,
			max_mentions_of_me: max_mentions_of_me_id,
			num_mentions_of_me: num_mentions_of_me,
			max_retweets_by_me: max_retweets_by_me_id,
			num_retweets_by_me: num_retweets_by_me,
			)
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
