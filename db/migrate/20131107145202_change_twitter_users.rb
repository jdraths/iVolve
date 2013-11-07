class ChangeTwitterUsers < ActiveRecord::Migration
  	
  	def self.up
  	  change_table :twitter_users do |t|
  		t.integer :favorite_int_count
  		t.integer :followers_int_count
  		t.integer :friends_int_count
  		t.integer :listed_int_count
  		t.integer :tweet_int_count
  	  end
	end

    def self.down
  	  change_table :twitter_users do |t|
  		t.remove :tweet_int_count
  		t.remove :listed_int_count
  		t.remove :friends_int_count
  		t.remove :followers_int_count
  		t.remove :favorite_int_count
  	  end
    end
end

