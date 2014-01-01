class AddRetweetsAndMentionsToIvolveIndexModel < ActiveRecord::Migration
  def self.up
  	change_table :ivolve_indices do |t|
  		t.integer :iv_twitter_retweets_of_me
  		t.integer :iv_twitter_mentions_of_me
  		t.integer :iv_twitter_retweets_by_me
  	end
  end

  def self.down
  	change_table :ivolve_indices do |t|
  		t.remove :iv_twitter_retweets_by_me
  		t.remove :iv_twitter_mentions_of_me
  		t.remove :iv_twitter_retweets_of_me
  	end
  end
end
