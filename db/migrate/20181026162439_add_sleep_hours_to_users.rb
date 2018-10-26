class AddSleepHoursToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sleep_hours, :float
  end
end
