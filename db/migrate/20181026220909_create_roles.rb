class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles, id: false do |t|
      t.string :label, primary_key: true

      t.timestamps
    end
  end
end
