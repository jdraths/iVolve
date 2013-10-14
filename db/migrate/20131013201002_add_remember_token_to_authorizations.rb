class AddRememberTokenToAuthorizations < ActiveRecord::Migration
  def change
  	add_column :authorizations, :remember_token, :string
  	add_index :authorizations, :remember_token
  end
end
