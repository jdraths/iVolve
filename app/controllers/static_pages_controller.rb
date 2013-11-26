class StaticPagesController < ApplicationController
    include StatsHelper
# the following before_filter makes stats_view method (from stats_helper.rb) available in show.
  before_filter :stats_view,    only: :home

  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page], per_page: 4)
      # @who is defined for graph displays in _wellness_bar.html.erb
      @who = 'iVolve'
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
