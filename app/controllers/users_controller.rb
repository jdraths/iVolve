class UsersController < ApplicationController
  before_action :signed_in_user,  
                  only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  include StatsHelper

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    if my_profile?
      stats_view
      @who = 'iVolve'
    else
      stats_compare
      @who = @user.name
    end
  end

  def new
  	@user = env['omniauth.identity'] || User.new
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
