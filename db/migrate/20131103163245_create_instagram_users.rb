class CreateInstagramUsers < ActiveRecord::Migration
	def up
	    create_table :instagram_users do |t|
	      t.string :full_name
	      t.string :username
	      t.text :bio, :limit => nil
	      t.string :uid
	      t.text :profile_picture, :limit => nil
	      t.text :website, :limit => nil
	      t.string :num_followers
	      t.string :num_following
	      t.string :num_media
	      t.string :num_likes_out

	      t.timestamps
	    end
	end
	def down
		drop_table :instagram_users
	end
end
