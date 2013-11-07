class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      # Need to fix this method
      if twitter?   # if twitter? definitely works
        # this twitter_users column should be renamed from name to screen_name
        @twitter_int_friends = @twitter_auth_user.friends_int_count
        @twitter_avg_friends = avg_num(TwitterUser, 'friends_int_count')
        @twitter_int_followers = @twitter_auth_user.followers_int_count
        @twitter_avg_followers = avg_num(TwitterUser, 'followers_int_count')
        @twitter_int_sent = @twitter_auth_user.tweet_int_count
        @twitter_avg_sent = avg_num(TwitterUser, 'tweet_int_count')
        @twitter_int_favorites = @twitter_auth_user.favorite_int_count
        @twitter_avg_fav = avg_num(TwitterUser, 'favorite_int_count')
        @twitter_int_lists = @twitter_auth_user.listed_int_count
        @twitter_avg_lists = avg_num(TwitterUser, 'listed_int_count')
      end
      if facebook?
        @facebook_name = @facebook_auth_user.name
        # how common are bios?  Let's IF the bio in.
        @facebook_bio = @facebook_auth_user.bio
        @facebook_birthday = @facebook_auth_user.birthday
        @facebook_int_friends = @facebook_auth_user.int_friends
        @facebook_avg_friends = avg_num(FacebookUser, 'int_friends')
        @facebook_int_likes = @facebook_auth_user.int_likes
        @facebook_avg_likes = avg_num(FacebookUser, 'int_likes')
        @facebook_int_posts = @facebook_auth_user.int_posts
        @facebook_avg_posts = avg_num(FacebookUser, 'int_posts')
        @facebook_int_statuses = @facebook_auth_user.int_statuses
        @facebook_avg_statuses = avg_num(FacebookUser, 'int_statuses')
        @facebook_int_achievements = @facebook_auth_user.int_achievements
        @facebook_avg_achievements = avg_num(FacebookUser, 'int_achievements')
        @facebook_int_subscribers = @facebook_auth_user.int_subcribers
        @facebook_avg_subscribers = avg_num(FacebookUser, 'int_subcribers')
        @facebook_int_subscribed_to = @facebook_auth_user.int_subscribed_to
        @facebook_avg_subscribed_to = avg_num(FacebookUser, 'int_subscribed_to')
      end
      if instagram?
        @instagram_int_followers = @instagram_auth_user.int_followers
        @instagram_avg_followers = avg_num(InstagramUser, 'int_followers')
        @instagram_int_following = @instagram_auth_user.int_following
        @instagram_avg_following = avg_num(InstagramUser, 'int_following')
        @instagram_int_media = @instagram_auth_user.int_media
        @instagram_avg_media = avg_num(InstagramUser, 'int_media')
        @instagram_int_likes_out = @instagram_auth_user.int_likes_out
        @instagram_avg_likes_out = avg_num(InstagramUser, 'int_likes_out')
      end
      if fitbit?
        @fitbit_height_int = @fitbit_auth_user.height_int
        @fitbit_avg_height = avg_num(FitbitUser, 'height_int')
        @fitbit_weight_int = @fitbit_auth_user.weight_int
        @fitbit_avg_weight = avg_num(FitbitUser, 'weight_int')
        @fitbit_stride_length_run_int = @fitbit_auth_user.stride_length_run_int
        @fitbit_avg_length_run = avg_num(FitbitUser, 'stride_length_run_int')
        @fitbit_stride_length_walk_int = @fitbit_auth_user.stride_length_walk_int
        @fitbit_avg_length_walk = avg_num(FitbitUser, 'stride_length_walk_int')
        @fitbit_lifetime_tot_active_score_int = @fitbit_auth_user.lifetime_tot_active_score_int
        @fitbit_avg_life_active_score = avg_num(FitbitUser, 'lifetime_tot_active_score_int')
        @fitbit_best_tot_active_score_int = @fitbit_auth_user.best_tot_active_score_int
        @fitbit_avg_best_active_score = avg_num(FitbitUser, 'best_tot_active_score_int')
        @fitbit_best_tot_active_date = @fitbit_auth_user.best_tot_active_score_date
        @fitbit_lifetime_tot_cal_out_int = @fitbit_auth_user.lifetime_tot_cal_out_int
        @fitbit_avg_life_cal_out = avg_num(FitbitUser, 'lifetime_tot_cal_out_int')
        @fitbit_best_tot_cal_out_int = @fitbit_auth_user.best_tot_cal_out_int
        @fitbit_avg_best_cal_out = avg_num(FitbitUser, 'best_tot_cal_out_int')
        @fitbit_best_tot_cal_out_date = @fitbit_auth_user.best_tot_cal_out_date
        @fitbit_lifetime_tot_dist_int = @fitbit_auth_user.lifetime_tot_dist_int
        @fitbit_avg_life_tot_dist = avg_num(FitbitUser, 'lifetime_tot_dist_int')
        @fitbit_best_tot_dist_int = @fitbit_auth_user.best_tot_dist_int
        @fitbit_avg_best_dist = avg_num(FitbitUser, 'best_tot_dist_int')
        @fitbit_best_tot_dist_date = @fitbit_auth_user.best_tot_dist_date
        @fitbit_lifetime_tot_steps_int = @fitbit_auth_user.lifetime_tot_steps_int
        @fitbit_avg_life_tot_steps = avg_num(FitbitUser, 'lifetime_tot_steps_int')
        @fitbit_best_tot_steps_int = @fitbit_auth_user.best_tot_steps_int
        @fitbit_avg_best_tot_steps = avg_num(FitbitUser, 'best_tot_steps_int')
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
