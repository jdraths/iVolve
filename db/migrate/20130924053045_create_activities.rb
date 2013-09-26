class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :achievement_id

      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, [:achievement_id, :created_at]
  end
end
