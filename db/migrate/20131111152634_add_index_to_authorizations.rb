class AddIndexToAuthorizations < ActiveRecord::Migration
  def change
  	add_index :authorizations, :user_id
  	add_index :authorizations, :uid
  	add_index :authorizations, :provider
  end
end
