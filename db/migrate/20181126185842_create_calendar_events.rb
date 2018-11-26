class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :event_type
      t.string :event_id
      t.string :html_link
      t.datetime :start_date
      t.datetime :end_date


      t.timestamps
    end

    add_index :calendar_events, :user_id
    add_index :calendar_events, [:user_id, :event_id, :event_type], unique: true
  end
end
