class AddUserdataToTwitterUsers < ActiveRecord::Migration
  def change
  	change_table :twitter_users do |t|
	  t.remove :provider, :uid
	  t.integer :user_id
	  t.string :connections
	  t.string :contributors_enabled
	  t.string :default_profile
	  t.string :default_profile_image
	  t.string :description
	  t.string :favorite_count
	  t.string :follow_request_sent
	  t.string :followers_count
	  t.string :friends_count
	  t.string :geo_enabled
	  t.string :is_translator
	  t.string :lang
	  t.string :listed_count
	  t.string :location
	  t.string :notifications
	  t.string :protected
	  t.string :tweet_count
	  t.string :time_zone
	  t.string :url
	  t.string :utc_offset
	  t.string :verified
	  t.string :description_urls
	  t.string :status
	end
  end
end
