class Authorization < ActiveRecord::Base
	belongs_to :user
	validates :uid, presence: true, uniqueness: {scope: :provider}
	validates :provider, presence: true
	after_validation :report_validation_errors_to_rollbar

	def self.find_from_omniauth(auth)
		find_by_provider_and_uid(auth['provider'], auth['uid']) #|| create_from_omniauth(auth)
		# Use the below lines to re-write oauth-token and secret?
		#user.oauth_token = auth["credentials"]["token"]
		#user.oauth_secret = auth["credentials"]["secret"]
		#user.save!
		#user
	end

	def self.create_from_omniauth(auth)
		#Facebook Tokens expire so credentials must be updated.  Facebook Railscast shows how to do this.
		create(uid: auth['uid'],
			provider: auth['provider'],
			screen_name: auth['info']['nickname'],
			oauth_token: auth["credentials"]["token"],
			oauth_secret: auth["credentials"]["secret"]
			)
		#user.oauth_token = auth["credentials"]["token"]
		#user.oauth_secret = auth["credentials"]["secret"]
		#user.save!
		#user
		# From stefano bernardi
		# create(uid: auth['uid'], provider: auth['provider'])
		# Not in stefano bernardi model
		# user ||= User.create_from_omniauth!(auth)
		# Authorization.create(
		#	user: user,
		#	uid: auth['uid'],
		#	provider: auth['provider']
		#	)
	end
	# This method must be run to grab credentials from everything but Identity.  this cannot be grabbed in identity, will fail.
	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |authorized|
			authorized.uid = auth.uid
			authorized.provider = auth.provider
			authorized.name = auth.info.name
			#authorized.email = auth.info.email
			#authorized.screen_name = auth.info.nickname
			#authorized.first_name = auth.info.first_name
			#authorized.last_name = auth.info.last_name
			#authorized.location = auth.info.location
			#authorized.description = auth.info.description
			#authorized.image = auth.info.image
			#authorized.phone = auth.info.phone
			authorized.oauth_token = auth.credentials.token
			authorized.oauth_secret = auth.credentials.secret
			unless auth.credentials.expires_at.nil?
				authorized.oauth_expires_at = Time.at(auth.credentials.expires_at)
			end
			authorized.save!
		end
	end

 #below is put into Application controller....
	#def twitter
	#	if provider == "twitter"
	#		@twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
	#	end
	#end
end
