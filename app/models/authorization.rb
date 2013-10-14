class Authorization < ActiveRecord::Base
	belongs_to :user
	validates :uid, presence: true, uniqueness: {scope: :provider}
	validates :provider, presence: true

	def self.find_from_omniauth(auth)
		find_by_provider_and_uid(auth['provider'], auth['uid'])
	end

	def self.create_from_omniauth(auth)
		create(uid: auth['uid'], provider: auth['provider'])
		# Not in stefano bernardi model
		# user ||= User.create_from_omniauth!(auth)
		# Authorization.create(
		#	user: user,
		#	uid: auth['uid'],
		#	provider: auth['provider']
		#	)
	end
end
