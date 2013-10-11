class CreateFetchTweets < ActiveRecord::Migration
  def change
    create_table :fetch_tweets do |t|
      t.string :tweet_id
      t.string :screen_name
      t.text :content

      t.timestamps
    end
  end
end
