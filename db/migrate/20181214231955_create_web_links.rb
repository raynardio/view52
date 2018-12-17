class CreateWebLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :web_links do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type

      t.string :url
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
