class AddRetweetsMentionsColsToTwitterUsers < ActiveRecord::Migration
  def self.up
  	change_table :twitter_users do |t|
  		t.integer :max_retweets_of_me
  		t.integer :num_retweets_of_me
  		t.integer :max_mentions_of_me
  		t.integer :num_mentions_of_me
  		t.integer :max_retweets_by_me
  		t.integer :num_retweets_by_me
  	end
  end

  def self.down
  	change_table :twitter_users do |t|
  		t.integer :num_retweets_by_me
  		t.integer :max_retweets_by_me
  		t.integer :num_mentions_of_me
  		t.integer :max_mentions_of_me
  		t.integer :num_retweets_of_me
  		t.integer :max_retweets_of_me
  	end
  end
end
