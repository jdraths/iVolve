class AddNumbersToFacebookUsers < ActiveRecord::Migration
  def change
  	add_column :facebook_users, :num_achievements, :string
  	add_column :facebook_users, :num_subcribers, :string
  	add_column :facebook_users, :num_subscribed_to, :string
  	add_column :facebook_users, :num_statuses, :string
  	add_column :facebook_users, :num_posts, :string
  	add_column :facebook_users, :num_likes, :string
  	add_column :facebook_users, :num_friends, :string
  end
end
