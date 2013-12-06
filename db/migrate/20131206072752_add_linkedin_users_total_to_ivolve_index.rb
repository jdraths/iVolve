class AddLinkedinUsersTotalToIvolveIndex < ActiveRecord::Migration
  def self.up
  	change_table :ivolve_indices do |t|
  		t.integer :linkedin_users_total
  	end
  end

  def self.down
  	change_table :ivolve_indices do |t|
  		t.remove :linkedin_users_total
  	end
  end
end
