# This should follow Rails Casts

class Identity < OmniAuth::Identity::Models::ActiveRecord
	# link Identity to Authorization
	belongs_to :authorization
	# above
	has_secure_password
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
			uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 6 }

	#before_create :create_remember_token

#	def Identity.new_remember_token
#		SecureRandom.urlsafe_base64
#	end
#
#	def Identity.encrypt(token)
#		Digest::SHA1.hexdigest(token.to_s)
#	end

	# from Rails cast omniauth
	#def self.from_omniauth(auth)
	#	where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
	#end

	#def self.create_from_omniauth(auth)
	#	create! do |user|
	#		user.provider = auth["provider"]
	#		user.uid = auth["uid"]
	#		user.name = auth["info"]["nickname"]
	#	end
	#end

	#private

#		def create_remember_token
#			self.remember_token = Identity.encrypt(Identity.new_remember_token)
#		end
end
