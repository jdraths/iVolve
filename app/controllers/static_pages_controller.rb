class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      # Need to fix this method
      #if twitter?
        # this twitter_users column should be renamed from name to screen_name
      #  @authorization = Authorization.find_by_user_id_and_provider(current_user, 'twitter')
      #  @twitter_user = TwitterUser.find_by_uid(@authorization.uid)
      #  @twitter_name = @twitter_user.name
      #  @twitter_description = @twitter_user.description
      #  @twitter_friends = @twitter_user.friends_count
      #  @twitter_followers = @twitter_user.followers_count
      #  @twitter_sent = @twitter_user.tweet_count
      #  @twitter_favorites = @twitter_user.favorite_count
      #  @twitter_lists = @twitter_user.listed_count
      #end
  	end
  end

  def help
  end

  def about
  end

  def contact

  end
  
end
