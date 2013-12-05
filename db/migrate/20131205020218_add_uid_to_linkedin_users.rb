class AddUidToLinkedinUsers < ActiveRecord::Migration
  def self.up
  	change_table :linkedin_users do |t|
  		t.string :uid
  	end
  end

  def self.down
  	change_table :linkedin_users do |t|
  		t.remove :uid
  	end
  end
end
