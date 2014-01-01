class AddLikedMaxIdToInstagramUsers < ActiveRecord::Migration
  def self.up
  	change_table :instagram_users do |t|
  		t.integer :max_liked_id, limit: 8
  	end
  end

  def self.down
  	change_table :instagram_users do |t|
  		t.remove :max_liked_id
  	end
  end
end
