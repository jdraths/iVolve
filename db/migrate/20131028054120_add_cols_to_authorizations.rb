class AddColsToAuthorizations < ActiveRecord::Migration
  def change
  	add_column :authorizations, :email, :string
  	add_column :authorizations, :first_name, :string
  	add_column :authorizations, :last_name, :string
  	add_column :authorizations, :location, :string
  	add_column :authorizations, :description, :string
  	add_column :authorizations, :image, :string
  	add_column :authorizations, :phone, :string
  end
end
