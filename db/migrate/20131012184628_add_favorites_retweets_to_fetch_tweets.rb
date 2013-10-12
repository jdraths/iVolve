class AddFavoritesRetweetsToFetchTweets < ActiveRecord::Migration
  def change
    add_column :fetch_tweets, :favorite_count, :string
    add_column :fetch_tweets, :retweet_count, :string
  end
end
