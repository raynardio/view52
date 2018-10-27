class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :role_category_id
      t.string :term
      t.string :text

      t.timestamps
    end

    add_index :goals, :user_id
  end
end
