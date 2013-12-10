class ChangeIvLinkedinColsFromStringToInt < ActiveRecord::Migration
  def self.up
  	change_table :ivolve_indices do |t|
  		t.change :iv_linkedin_connections, :integer, :limit => nil
  		t.change :iv_linkedin_group_memberships, :integer, :limit => nil
  		t.change :iv_linkedin_job_suggestions, :integer, :limit => nil
  		t.change :iv_linkedin_job_bookmarks, :integer, :limit => nil
  		t.change :iv_linkedin_shares, :integer, :limit => nil
  	end
  end

  def self.down
  	change_table :ivolve_indices do |t|
  		t.change :iv_linkedin_shares, :string
  		t.change :iv_linkedin_job_bookmarks, :string
  		t.change :iv_linkedin_job_suggestions, :string
  		t.change :iv_linkedin_group_memberships, :string
  		t.change :iv_linkedin_connections, :string
  	end
  end
end
