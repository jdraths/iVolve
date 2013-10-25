class AddArrayColsToFetchTweets < ActiveRecord::Migration
  def change
  	add_column :fetch_tweets, :geo_array, :array
  	add_column :fetch_tweets, :hashtags_array, :array
  	add_column :fetch_tweets, :media_array, :array
  	add_column :fetch_tweets, :symbols_array, :array
  	add_column :fetch_tweets, :incl_url_array, :array
  end
end
