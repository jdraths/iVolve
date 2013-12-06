module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def linkedin_authorized?
		@linkedin = Authorization.find_by_user_id_and_provider(current_user, 'linkedin')
		!@linkedin.nil?
	end

	def linkedin?
		if linkedin_authorized?
			@linkedin_auth_user = LinkedinUser.find_by_uid(@linkedin.uid)
			!@linkedin_auth_user.nil?
		end
	end

	def twitter_authorized?
		@twitter = Authorization.find_by_user_id_and_provider(current_user, 'twitter')
		!@twitter.nil?
	end

	def twitter?
		if twitter_authorized?
			@twitter_auth_user = TwitterUser.find_by_uid(@twitter.uid)
			!@twitter_auth_user.nil?
		end
	end

	def facebook_authorized?
		@facebook = Authorization.find_by_user_id_and_provider(current_user, 'facebook')
		!@facebook.nil?
	end

	def facebook?
		if facebook_authorized?
			@facebook_auth_user = FacebookUser.find_by_uid(@facebook.uid)
			!@facebook_auth_user.nil?
		end
	end

	def facebook_expired?
		if facebook?
			if @facebook.expired_token == true
				true
			else
				false
			end
		end
	end
	
	def instagram_authorized?
		@instagram = Authorization.find_by_user_id_and_provider(current_user, 'instagram')
		!@instagram.nil?
	end

	def instagram?
		if instagram_authorized?
			@instagram_auth_user = InstagramUser.find_by_uid(@instagram.uid)
			!@instagram_auth_user.nil?
		end
	end

	def foursquare_authorized?
		@foursquare = Authorization.find_by_user_id_and_provider(current_user, 'foursquare')
		!@foursquare.nil?
	end

	def foursquare?
		if foursquare_authorized?
			@foursquare_auth_user = FoursquareUser.find_by_uid(@foursquare.uid)
			!@foursquare_auth_user.nil?
		end
	end

	def fitbit_authorized?
		@fitbit = Authorization.find_by_user_id_and_provider(current_user, 'fitbit')
		!@fitbit.nil?
	end

	def fitbit?
		if fitbit_authorized?
			@fitbit_auth_user = FitbitUser.find_by_encoded_id(@fitbit.uid)
			!@fitbit_auth_user.nil?
		end
	end

	def current_user=(user)
		@current_user = user
		session[:user_id] = user.nil? ? user : user.id
	end

	def current_user
		#remember_token = User.encrypt(cookies[:remember_token])
		#@current_user ||= User.find_by(remember_token: remember_token)
		@current_user ||= User.find_by_id(session[:user_id])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in."
		end
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

end
