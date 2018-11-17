class AddIconClassToRoleCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :role_categories, :icon_class, :string
  end
end
