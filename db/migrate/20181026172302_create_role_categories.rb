class CreateRoleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :role_categories, id: false do |t|
      t.string :label, primary_key: true

      t.timestamps
    end
  end
end
