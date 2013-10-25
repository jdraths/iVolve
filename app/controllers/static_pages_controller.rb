class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      if twitter?
        # this twitter_users column should be renamed from name to screen_name
        @twitter_user = current_user.twitter
        @twitter_name = @twitter_user.name
        @twitter_description = @twitter_user.description
        @twitter_friends = @twitter_user.friends_count
        @twitter_followers = @twitter_user.followers_count
        @twitter_sent = @twitter_user.tweet_count
        @twitter_favorites = @twitter_user.favorite_count
        @twitter_lists = @twitter_user.listed_count
      else
        @twitter_user = nil
        @twitter_name = nil
        @twitter_description = nil
        @twitter_friends = nil
        @twitter_followers = nil
        @twitter_sent = nil
        @twitter_favorites = nil
        @twitter_lists = nil
      end
  	end
  end

  def help
  end

  def about
  end

  def contact
    #temporary controller for showing tweets
    if signed_in?
      @timeline = FetchTweet.pull_user_timeline(current_user)

    end
  end
  
end
