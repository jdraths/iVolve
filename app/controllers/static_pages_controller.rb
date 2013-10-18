class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end

  def help
    if signed_in?

      @twitter_name = Authorization.find_by_user_id(:screen_name)
    end
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
