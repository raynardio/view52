class AddFieldsToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :description, :text
    add_column :goals, :goal_date, :date
  end
end
