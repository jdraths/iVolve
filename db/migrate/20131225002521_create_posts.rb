class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :tags
      t.string :source_url
      t.string :source_content
      t.string :source_title

      t.timestamps
    end
  end
end
