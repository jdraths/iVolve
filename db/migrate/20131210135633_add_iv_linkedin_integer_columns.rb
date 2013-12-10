class AddIvLinkedinIntegerColumns < ActiveRecord::Migration
  def self.up
  	change_table :ivolve_indices do |t|
  		t.integer :iv_linkedin_connections_int
  		t.integer :iv_linkedin_group_memberships_int
  		t.integer :iv_linkedin_job_suggestions_int
  		t.integer :iv_linkedin_job_bookmarks_int
  		t.integer :iv_linkedin_shares_int
  	end
  end

  def self.down
  	change_table :ivolve_indices do |t|
  		t.remove :iv_linkedin_shares_int
  		t.remove :iv_linkedin_job_bookmarks_int
  		t.remove :iv_linkedin_job_suggestions_int
  		t.remove :iv_linkedin_group_memberships_int
  		t.remove :iv_linkedin_connections_int
  	end
  end
end
