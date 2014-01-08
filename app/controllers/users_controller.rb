class UsersController < ApplicationController
  before_action :signed_in_user,  except: [:new]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  include StatsHelper
  include GraphHelper

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    if my_profile?
      stats_view(current_user)
      @who = 'iVolve Index'
    else
      stats_compare
      @who = @user.name
    end
  end

  def new
  	@user = env['omniauth.identity'] || User.new
    #Rollbar.report_message("Someone visited the Sign Up page via UsersController new action!")
    # this does not necessarilly mean they have signed-up, just that they visited the page.
    if @user.save
      UserMailer.welcome_email(@user).deliver
      Rollbar.report_message("Identity created & saved via UsersController new action!")
    end
  end

  def create
    @user = User.new(user_params)   # Not the final implementation!
    if @user.save
      sign_in @user
      Rollbar.report_message("User created via UsersController create action!")
      flash[:success] = "Welcome to iVolve!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, 
                                        :password_confirmation)
  	end

    # Before filters
    def my_profile?
        current_user?(@user)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
