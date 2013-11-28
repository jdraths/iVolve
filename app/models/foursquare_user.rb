class FoursquareUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first

	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(friends_count + badges_count + following_count + mayor_count) as social,
			 sum(photos_count + checkins_count + tips_count) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(friends_count) as friends_count, sum(following_count) as following_count, sum(checkins_count) as checkins_count, sum(badges_count) as badges_count, sum(mayor_count) as mayor_count, sum(tips_count) as tips_count, sum(photos_count) as photos_count")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		@foursquare_auth = Authorization.find_by_user_id_and_provider(user, 'foursquare')
		foursquare_client = Foursquare2::Client.new(oauth_token: @foursquare_auth.oauth_token)
		user = foursquare_client.user('self')
		create!(
			firstname: user['firstName'],
			lastname: user['lastName'],
			uid: user['id'],
			gender: user['gender'],
			friends_count: user['friends']['count'],
			badges_count: user['badges']['count'],
			tips_count: user['tips']['count'],
			home_city: user['homeCity'],
			bio: user ['bio'],
			email: user['contact']['email'],
			facebook_uid: user['contact']['facebook'],
			mayor_count: user['mayorships']['count'],
			checkins_count: user['checkins']['count'],
			following_count: user['following']['count'],
			photos_count: user['photos']['count'],
			scores_max: user['scores']['max'],
			scores_recent: user['scores']['recent'],
			)
	end

	def self.sched_user_data
		# twitter_sched could be a scope?
		foursquare_sched = Authorization.where(provider: 'foursquare') 
		# is there a better way to run the following method once we have 1000s of foursquare auths??
		foursquare_sched.each do |foursquare_sched|
			FoursquareUser.pull_user_data(foursquare_sched.user)
		end
	end
end
