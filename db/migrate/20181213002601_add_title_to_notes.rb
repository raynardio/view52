class AddTitleToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :title, :string
    add_index :notes, :title
  end
end
