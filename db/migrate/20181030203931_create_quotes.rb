class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :quote_type
      t.string :text

      t.timestamps
    end
  end
end
