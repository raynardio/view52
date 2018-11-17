class CreateUserRoleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_role_categories do |t|
      t.integer :user_id, null: false
      t.string :role_category_id, null: false
      t.integer :importance, null: false

      t.timestamps
    end

    add_index :user_role_categories, :user_id
    add_index :user_role_categories, [:user_id, :role_category_id], unique: true
  end
end
