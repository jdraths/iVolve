class AddColsToIvolveIndex < ActiveRecord::Migration
  def self.up
  	change_table :ivolve_indices do |t|
  		t.string :iv_linkedin_connections
  		t.string :iv_linkedin_group_memberships
  		t.string :iv_linkedin_job_suggestions
  		t.string :iv_linkedin_job_bookmarks
  		t.string :iv_linkedin_shares
  	end
  end

  def self.down
  	change_table :ivolve_indices do |t|
  		t.remove :iv_linkedin_shares
  		t.remove :iv_linkedin_job_bookmarks
  		t.remove :iv_linkedin_job_suggestions
  		t.remove :iv_linkedin_group_memberships
  		t.remove :iv_linkedin_connections
  	end
  end
end
