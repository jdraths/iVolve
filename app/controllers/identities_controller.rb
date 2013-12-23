# Should closely match Users Controller.
class IdentitiesController < ApplicationController
  #before_action :signed_in_user,  
  #                only: [:index, :edit, :update, :destroy, :following, :followers]
  #before_action :correct_user,    only: [:edit, :update]
  #before_action :admin_user,      only: :destroy

  #def index
  #  @users = User.paginate(page: params[:page])
  #end

  #def show
  #	@user = User.find(params[:id])
  #  @microposts = @user.microposts.paginate(page: params[:page])
  #end

  def new
  	#@identity = Identity.new
    @identity = env['omniauth.identity']
    if @identity.save
      UserMailer.welcome_email(@user).deliver
      Rollbar.report_message("Identity created via IdentitiesController new action!")
    end
  end

  def create
  	@identity = Identity.new(user_params)		# Not the final implementation!
  	if @identity.save
      sign_in @identity
      flash[:success] = "Welcome to iVolve!"
  		redirect_to @identity
  	else
  		render 'new'
  	end
    Rollbar.report_message("Identity created via IdentitiesController create action!")
  end

  def destroy
    Identity.find(params[:id]).destroy
    flash[:success] = "Identity destroyed."
    redirect_to users_url
  end

  def edit
  end

  def update
    if @identity.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @identity
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:identity).permit(:name, :email, :password, 
                                        :password_confirmation)
  	end

    # Before filters

    def correct_user
      @identity = Identity.find(params[:id])
      redirect_to(root_url) unless current_user?(@identity)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
