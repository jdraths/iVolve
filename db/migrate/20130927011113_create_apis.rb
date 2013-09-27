class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.integer :user_id
      t.string :company
      t.integer :company_id
      t.string :con_key
      t.string :con_secret
      t.string :access_token
      t.string :access_secret

      t.timestamps
    end

    add_index :apis, :user_id
  end
end
