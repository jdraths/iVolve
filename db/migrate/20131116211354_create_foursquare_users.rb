class CreateFoursquareUsers < ActiveRecord::Migration
  def change
    create_table :foursquare_users do |t|
    	t.string :firstname
    	t.string :lastname
    	t.string :uid
    	t.string :gender
    	t.integer :friends_count
    	t.integer :badges_count
    	t.integer :tips_count
    	t.string :home_city
    	t.string :bio
    	t.string :email
    	t.string :facebook_uid
    	t.integer :mayor_count
    	t.integer :checkins_count
    	t.integer :following_count
    	t.integer :photos_count
    	t.integer :scores_max
    	t.integer :scores_recent
      t.timestamps
    end
  end
end
