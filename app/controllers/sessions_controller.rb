class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination' 
			render 'new'
		end
#------------ below added with Sign-In with Twitter Github
#		session[:access_token] = request.env['omniauth.auth']['credentials']['token']
#    	session[:access_secret] = request.env['omniauth.auth']['credentials']['secret']
#   		redirect_to show_path, notice: "Signed in"
	end

#	def show
#		if session['access_token'] && session['access_secret']
#      		@user = client.user(include_entities: true)
#    	else
#      		redirect_to failure_path
#    	end
#  	end

#	def error
#	    flash[:error] = "Sign in with Twitter failed"
#	    redirect_to root_path
#	end
#------------- above
	def destroy
		sign_out
		redirect_to root_url
	end
end
