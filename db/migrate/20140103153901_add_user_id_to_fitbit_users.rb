class AddUserIdToFitbitUsers < ActiveRecord::Migration
  def self.up
  	change_table :fitbit_users do |t|
  		t.integer :user_id
  	end
  end

  def self.down
  	change_table :fitbit_users do |t|
  		t.remove :user_id
  	end
  end
end
