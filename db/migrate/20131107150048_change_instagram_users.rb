class ChangeInstagramUsers < ActiveRecord::Migration

	def self.up
  	  change_table :instagram_users do |t|
  		t.integer :int_followers
  		t.integer :int_following
  		t.integer :int_media
  		t.integer :int_likes_out
  	  end
	end

    def self.down
  	  change_table :instagram_users do |t|
  		t.remove :int_likes_out
  		t.remove :int_media
  		t.remove :int_following
  		t.remove :int_followers
  	  end
    end
end
