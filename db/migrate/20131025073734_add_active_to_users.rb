class AddActiveToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :active_user, :boolean, default: true
  end
end
