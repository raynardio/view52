class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :item_id
      t.string :item_type
      t.string :category

      t.timestamps
    end
  end
end
