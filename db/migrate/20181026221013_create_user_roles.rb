class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.integer :user_id, null: false
      t.string :role_id, null: false
      t.string :tense

      t.timestamps
    end

    add_index :user_roles, [:role_id, :user_id], unique: true
  end
end
