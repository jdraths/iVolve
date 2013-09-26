class AddValueToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :value, :string
    add_column :activities, :app_log_id, :string
    add_column :activities, :time, :string
    add_column :activities, :description, :string
  end
end
