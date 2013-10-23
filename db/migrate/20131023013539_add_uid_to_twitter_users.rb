class AddUidToTwitterUsers < ActiveRecord::Migration
  def change
  	change_table :twitter_users do |t|
  		t.rename :protected, :protected_user
  		t.integer :uid
  	end
  end
end
