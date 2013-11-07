class ChangeFacebookUsers < ActiveRecord::Migration
  def up
  	change_table :facebook_users do |t|
  		t.change :num_friends, :integer
  		t.change :num_likes, :integer
  		t.change :num_posts, :integer
  		t.change :num_statuses, :integer
  		t.change :num_subscribed_to, :integer
  		t.change :num_subcribers, :integer
  		t.change :num_achievements, :integer
  	end
  end

  def down
  	change_table :facebook_users do |t|
  		t.change :num_achievements, :string
  		t.change :num_subcribers, :string
  		t.change :num_subscribed_to, :string
  		t.change :num_statuses, :string
  		t.change :num_posts, :string
  		t.change :num_likes, :string
  		t.change :num_friends, :string
  	end
  end
end
