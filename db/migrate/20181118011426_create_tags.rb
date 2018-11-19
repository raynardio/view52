class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :tag_type
      t.string :item_type
      t.string :label

      t.timestamps
    end

    add_index :tags, :user_id
    add_index :tags, [:user_id, :label]
    add_index :tags, [:user_id, :item_type]
    add_index :tags, [:user_id, :tag_type]
  end
end
