class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.integer :user_id
      t.string :item_type
      t.integer :item_id
      t.string :label

      t.timestamps
    end
  end
end
