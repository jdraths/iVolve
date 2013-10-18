class Authorization < ActiveRecord::Base
	belongs_to :user
	validates :uid, presence: true, uniqueness: {scope: :provider}
	validates :provider, presence: true
	validates :screen_name, presence: true

	def self.find_from_omniauth(auth)
		find_by_provider_and_uid(auth['provider'], auth['uid']) #|| create_from_omniauth(auth)
		# Use the below lines to re-write oauth-token and secret?
		#user.oauth_token = auth["credentials"]["token"]
		#user.oauth_secret = auth["credentials"]["secret"]
		#user.save!
		#user
	end

	def self.create_from_omniauth(auth)
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
	def self.credentials_from_omniauth(auth)
		user = where(auth.slice("provider", "uid")).first
		user.uid = auth['uid']
		user.provider = auth['provider']
		user.oauth_token = auth["credentials"]["token"]
		user.oauth_secret = auth["credentials"]["secret"]
		user.save!
		user
	end

#below is put into Application controller....
	#def twitter
	#	if provider == "twitter"
	#		@twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
	#	end
	#end
end
