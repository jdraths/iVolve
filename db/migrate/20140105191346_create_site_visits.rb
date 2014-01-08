class CreateSiteVisits < ActiveRecord::Migration
  def change
    create_table :site_visits do |t|
    	t.integer :user_id
    	t.string :url
      	t.timestamps
    end
  end
end
