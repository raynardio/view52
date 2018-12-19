class AddBase64ToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :base64, :string
  end
end
