class ChangeMaxLikedIdToBigintInstagramUsers < ActiveRecord::Migration
  def self.up
  	change_table :instagram_users do |t|
  		t.change :max_liked_id, :bigint
  	end
  end

  def self.down
  	change_table :instagram_users do |t|
  		t.change :max_liked_id, :integer, limit: 8
  	end
  end
end
