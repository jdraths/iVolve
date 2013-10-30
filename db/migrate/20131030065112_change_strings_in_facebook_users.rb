class ChangeStringsInFacebookUsers < ActiveRecord::Migration
  def up
  	change_table :facebook_users do |t|
  		t.change :bio, 					:text, :limit => nil
  		t.change :cover_photo, 			:text, :limit => nil
  		t.change :education, 			:text, :limit => nil
  		t.change :location, 			:text, :limit => nil
  		t.change :favorite_athletes, 	:text, :limit => nil
  		t.change :favorite_teams, 		:text, :limit => nil
  		t.change :profile_pic,		 	:text, :limit => nil
  		t.change :quotes, 				:text, :limit => nil
  		t.change :website, 				:text, :limit => nil
  		t.change :work, 				:text, :limit => nil
  	end
  end

  def down
  	change_table :facebook_users do |t|
  		t.change :work, :string
  		t.change :website, :string
  		t.change :quotes, :string
  		t.change :profile_pic, :string
  		t.change :favorite_teams, :string
  		t.change :favorite_athletes, :string
  		t.change :location, :string
  		t.change :education, :string
  		t.change :cover_photo, :string
  		t.change :bio, :string
  	end
  end
end
