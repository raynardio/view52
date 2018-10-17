class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :country
      t.string :city
      t.string :state
      t.string :zip
      t.string :sex
      t.string :marital_status
      t.string :education
      t.string :diet
      t.float :commute_hours
      t.float :exercise_hours
      t.float :weekly_hours

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
