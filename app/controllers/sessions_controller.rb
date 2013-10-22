class SessionsController < ApplicationController

	def new
	end

	def create
		@authorization = Authorization.find_from_omniauth(auth)
		#@credentials = Authorization.credentials_from_omniauth(auth)
	    if @authorization.nil?
	      # If no authorization was found, create a new one here
	      @authorization = Authorization.create_from_omniauth(auth)
	    #else
	    	#@credentials = Authorization.credentials_from_omniauth(auth)
	    	#@credentials.save!
	    end

		if signed_in?
			if @authorization.user == current_user
				#@credentials.save!
				# User is signed in so they are trying to link an authorization with their
		        # account. But we found the authorization and the user associated with it 
		        # is the current user. So the authorization is already associated with 
		        # this user. So let's display an error message.
				# Log the authorizing user in.
				redirect_to root_path, notice: "you have already linked this account."
			else
				# The authorization is not associated with the current_user so lets 
		        # associate the authorization
		        @authorization.user = current_user
		        @authorization.save
		        #@credentials.save!
		        redirect_to root_path, notice: "Account successfully authenticated."
		    end
		else # no user is signed_in
		    if @authorization.user.present?
		        # The authorization we found had a user associated with it so let's 
		        # just log them in here
		        self.current_user = @authorization.user
		        #@credentials.save!
		        redirect_to root_path, notice: "Signed in!"
		    else
		        # The authorization has no user assigned and there is no user signed in
		        # Our decision here is to create a new account for the user
		        # But your app may do something different (eg. ask the user
		        # if he already signed up with some other service)
		       	if @authorization.provider == 'identity'
		          u = User.find(@authorization.uid)
		          # If the provider is identity, then it means we already created a user
		          # So we just load it up
		        else
		          # otherwise we have to create a user with the auth hash
		          u = User.create_from_omniauth(auth)
		          # This method will only save user name... never used right now.
		          # NOTE: we will handle the different types of data we get back
		          # from providers at the model level in create_from_omniauth
		        end
		        # We can now link the authorization with the user and log him in
		        u.authorizations << @authorization
		        self.current_user = u
		        redirect_to root_path, notice: "Welcome to iVolve!"
		    end
		end
		

	   # below is from rails cast omniauth
	   #user = User.from_omniauth(auth_hash)
	   #session[:user_id] = user.id
	   #redirect_to root_url, notice: "Signed in."
	end
# This the native Login.  
#		user = User.find_by(email: params[:session][:email].downcase)
#		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
#			sign_in user
#			redirect_back_or user
#		else
			# Create an error message and re-render the signin form.
#			flash.now[:error] = 'Invalid email/password combination' 
#			render 'new'
#		end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "Signed out."

# This is native		
#		sign_out
#		redirect_to root_url
	end

	protected

	def auth
		request.env['omniauth.auth']
	end
end
