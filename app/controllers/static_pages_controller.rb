class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      # Need to fix this method
      if twitter?   # if twitter? definitely works
        # this twitter_users column should be renamed from name to screen_name
        @twitter_name = @twitter_user.name
        @twitter_description = @twitter_user.description
        @twitter_friends = @twitter_user.friends_count
        @twitter_followers = @twitter_user.followers_count
        @twitter_sent = @twitter_user.tweet_count
        @twitter_favorites = @twitter_user.favorite_count
        @twitter_lists = @twitter_user.listed_count
      end
      if facebook?
        @facebook_name = @facebook_user.name
        # how common are bios?  Let's IF the bio in.
        @facebook_bio = @facebook_user.bio
        @facebook_birthday = @facebook_user.birthday
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
