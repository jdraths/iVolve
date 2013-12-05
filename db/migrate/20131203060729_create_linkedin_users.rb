class CreateLinkedinUsers < ActiveRecord::Migration
  def change
    create_table :linkedin_users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :headline
    	t.integer :connections_size
    	t.integer :group_memberships_size
    	t.integer :job_suggestions_size
    	t.integer :job_bookmarks_size
    	t.integer :shares_size
      t.timestamps
    end
  end
end
