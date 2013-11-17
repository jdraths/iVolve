class AddFoursquareToIvIndex < ActiveRecord::Migration
  
  def self.up
  	change_table :ivolve_indices do |t|
  		t.integer :iv_foursquare_friends
  		t.integer :iv_foursquare_following
  		t.integer :iv_foursquare_checkins
  		t.integer :iv_foursquare_badges
  		t.integer :iv_foursquare_mayor
  		t.integer :iv_foursquare_tips
  		t.integer :iv_foursquare_photos
  	end
  end
  def self.down
  	change_table :ivolve_indices do |t|
  		t.integer :iv_foursquare_photos
  		t.integer :iv_foursquare_tips
  		t.integer :iv_foursquare_mayor
  		t.integer :iv_foursquare_badges
  		t.integer :iv_foursquare_checkins
  		t.integer :iv_foursquare_following
  		t.integer :iv_foursquare_friends
  	end
  end
end
