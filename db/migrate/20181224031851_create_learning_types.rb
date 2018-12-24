class CreateLearningTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_types do |t|
      t.string :label
      t.integer :user_id
      t.string :item_type
      t.integer :item_id

      t.timestamps
    end
  end
end
