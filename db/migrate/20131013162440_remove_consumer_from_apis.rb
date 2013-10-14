class RemoveConsumerFromApis < ActiveRecord::Migration
  def change
    remove_column :apis, :con_key, :string
    remove_column :apis, :con_secret, :string
  end
end
