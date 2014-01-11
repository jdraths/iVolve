class AddActionToSiteVisit < ActiveRecord::Migration
  def change
    add_column :site_visits, :action, :string
  end
end
