class ChangeMaxLikedIdFromBigintToString < ActiveRecord::Migration
  def self.up
  	change_table :instagram_users do |t|
  		t.change :max_liked_id, :string
  	end
  end

  def self.down
  	change_table :instagram_users do |t|
  		t.change :max_liked_id, :bigint
  	end
  end
end
