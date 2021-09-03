class FoodItem < ApplicationRecord
  enum course: [:first_course, :main_course, :drink]
  belongs_to :daily_menu, optional: true
  has_many :orders,  class_name: 'OrderItem', foreign_key: 'food_item_id'
end
