class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      # Need to fix this method
      if twitter?   # if twitter? definitely works
        # this twitter_users column should be renamed from name to screen_name
        @twitter_name = @twitter_auth_user.name
        @twitter_description = @twitter_auth_user.description
        @twitter_friends = @twitter_auth_user.friends_count
        @twitter_followers = @twitter_auth_user.followers_count
        @twitter_sent = @twitter_auth_user.tweet_count
        @twitter_favorites = @twitter_auth_user.favorite_count
        @twitter_lists = @twitter_auth_user.listed_count
      end
      if facebook?
        @facebook_name = @facebook_auth_user.name
        # how common are bios?  Let's IF the bio in.
        @facebook_bio = @facebook_auth_user.bio
        @facebook_birthday = @facebook_auth_user.birthday
        @facebook_num_friends = @facebook_auth_user.num_friends
        @facebook_num_likes = @facebook_auth_user.num_likes
        @facebook_num_posts = @facebook_auth_user.num_posts
        @facebook_num_statuses = @facebook_auth_user.num_statuses
        @facebook_num_achievements = @facebook_auth_user.num_achievements
        @facebook_num_subscribers = @facebook_auth_user.num_subcribers
        @facebook_num_subscribed_to = @facebook_auth_user.num_subscribed_to
      end
      if instagram?
        @instagram_username = @instagram_auth_user.username
        @instagram_bio = @instagram_auth_user.bio
        @instagram_num_followers = @instagram_auth_user.num_followers
        @instagram_num_following = @instagram_auth_user.num_following
        @instagram_num_media = @instagram_auth_user.num_media
        @instagram_num_likes_out = @instagram_auth_user.num_likes_out
        @instagram_website = @instagram_auth_user.website
      end
      if fitbit?
        @fitbit_display_name = @fitbit_auth_user.display_name
        @fitbit_height = @fitbit_auth_user.height
        @fitbit_weight = @fitbit_auth_user.weight
        @fitbit_member_since = @fitbit_auth_user.member_since
        @fitbit_stride_length_run = @fitbit_auth_user.stride_length_run
        @fitbit_stride_length_walk = @fitbit_auth_user.stride_length_walk
        @fitbit_lifetime_tot_active_score = @fitbit_auth_user.lifetime_tot_active_score
        @fitbit_best_tot_active_score_value = @fitbit_auth_user.best_tot_active_score_value
        @fitbit_best_tot_active_date = @fitbit_auth_user.best_tot_active_score_date
        @fitbit_lifetime_tot_cal_out = @fitbit_auth_user.lifetime_tot_cal_out
        @fitbit_best_tot_cal_out_value = @fitbit_auth_user.best_tot_cal_out_value
        @fitbit_best_tot_cal_out_date = @fitbit_auth_user.best_tot_cal_out_date
        @fitbit_lifetime_tot_dist = @fitbit_auth_user.lifetime_tot_dist
        @fitbit_best_tot_dist_value = @fitbit_auth_user.best_tot_dist_value
        @fitbit_best_tot_dist_date = @fitbit_auth_user.best_tot_dist_date
        @fitbit_lifetime_tot_steps = @fitbit_auth_user.lifetime_tot_steps
        @fitbit_best_tot_steps_value = @fitbit_auth_user.best_tot_steps_value
        @fitbit_best_tot_steps_date = @fitbit_auth_user.best_tot_steps_date
      end
  	end
  end

  def help
  end

  def about
  end

  def contact

  end
  
end
