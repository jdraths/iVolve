class ChangeTwitterUidAndTweetIdsToBigint < ActiveRecord::Migration
  def self.up
  	change_table :twitter_users do |t|
  		t.change :max_retweets_of_me, :bigint
  		t.change :num_retweets_of_me, :bigint
  		t.change :max_mentions_of_me, :bigint
  		t.change :num_mentions_of_me, :bigint
  		t.change :max_retweets_by_me, :bigint
  		t.change :num_retweets_by_me, :bigint
  		t.change :uid, :bigint
  	end
  end

  def self.down
  	change_table :twitter_users do |t|
  		t.change :uid, :integer
  		t.change :num_retweets_by_me, :integer
  		t.change :max_retweets_by_me, :integer
  		t.change :num_mentions_of_me, :integer
  		t.change :max_mentions_of_me, :integer
  		t.change :num_retweets_of_me, :integer
  		t.change :max_retweets_of_me, :integer
  	end
  end
end
