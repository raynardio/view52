class AddPrototypeAndAnnualViewToLifeEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :life_events, :prototype, :boolean, default: false
    add_column :life_events, :show_in_annual_view, :boolean, default: false
  end
end
