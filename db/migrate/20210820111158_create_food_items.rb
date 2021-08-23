class CreateFoodItems < ActiveRecord::Migration[6.1]
  def change
    create_table :food_items do |t|
      t.string :name
      t.decimal :price
      t.integer :course
      t.references :daily_menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
