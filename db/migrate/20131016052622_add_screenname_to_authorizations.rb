class AddScreennameToAuthorizations < ActiveRecord::Migration
  def change
  	add_column :authorizations, :screen_name, :string
  end
end
