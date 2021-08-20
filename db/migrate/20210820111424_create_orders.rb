class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :daily_menu, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :first_course_id
      t.integer :main_course_id
      t.integer :drink_course_id
      t.decimal :total_price

      t.timestamps
    end
  end
end
