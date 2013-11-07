class ChangeFacebookUsers < ActiveRecord::Migration

  def self.up
  	change_table :facebook_users do |t|
  		t.integer :int_friends
  		t.integer :int_likes
  		t.integer :int_posts
  		t.integer :int_statuses
  		t.integer :int_subscribed_to
  		t.integer :int_subscribers
  		t.integer :int_achievements
  	end
  end

  def self.down
  	change_table :facebook_users do |t|
  		t.remove :int_achievements
  		t.remove :int_subcribers
  		t.remove :int_subscribed_to
  		t.remove :int_statuses
  		t.remove :int_posts
  		t.remove :int_likes
  		t.remove :int_friends
  	end
  end
end
