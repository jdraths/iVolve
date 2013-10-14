class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :identities, :email, unique: true
  end
end
