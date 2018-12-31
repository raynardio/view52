class CreateLifeEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :life_events do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
