class FitbitUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.manual_user_data
		fitbit_auth = Authorization.find_by_user_id_and_provider(1, 'fitbit')
		my_key = "cfe66ba8f21941c292ff4a21b075cac3"
		my_secret = "9117581161064da9bfe8b36b2b79b689"
		user_token = fitbit_auth.oauth_token
		user_secret = fitbit_auth.oauth_secret
		client = Fitgem::Client.new(
			:consumer_key => my_key,
			:consumer_secret => my_secret,
			:token => user_token,
			:secret => user_secret,
		)
		client.activity_statistics
	end
end
