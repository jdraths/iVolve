class LinkedinUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first

	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(connections_size + group_memberships_size + job_suggestions_size + job_bookmarks_size) as social,
			 sum(shares_size) as creative")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.connections_line_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(connections_size + group_memberships_size) as connections,
			sum(job_suggestions_size + job_bookmarks_size + shares_size) as engagement")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.total_grouped_by_date(start)
		t = Time.zone.now
		time_now = t + t.utc_offset
		data = where(created_at: start.beginning_of_day..time_now.end_of_day)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(connections_size) as connections_size, sum(job_suggestions_size) as job_suggestions_size, sum(group_memberships_size) as group_memberships_size, sum(job_bookmarks_size) as job_bookmarks_size, sum(shares_size) as shares_size")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		linkedin_auth = Authorization.find_by_user_id_and_provider(user, 'linkedin')
		linkedin_client = LinkedIn::Client.new('7599bbb14sksaj', 'BdOY63uK55WnQSOS', linkedin_auth.oauth_token)
		profile = linkedin_client.profile
		connections = linkedin_client.connections
		group_memberships = linkedin_client.group_memberships
		job_bookmarks = linkedin_client.job_bookmarks
		job_suggestions = linkedin_client.job_suggestions
		shares = linkedin_client.shares
		create!(
			first_name: profile.first_name,
			last_name: profile.last_name,
			headline: profile.headline,
			connections_size: connections.total,
			group_memberships_size: group_memberships.total,
			job_suggestions_size: job_suggestions.total,
			job_bookmarks_size: job_bookmarks.total,
			shares_size: shares.total,
			uid: linkedin_auth.uid,
				)
	end

	def self.sched_user_data
		# twitter_sched could be a scope?
		linkedin_sched = Authorization.where(provider: 'linkedin') 
		# is there a better way to run the following method once we have 1000s of twitter auths??
		linkedin_sched.each do |linkedin_sched|
			LinkedinUser.pull_user_data(linkedin_sched.user)
		end
	end
end

