class FoodItem < ApplicationRecord
  enum course: [:first_course, :main_course, :drink]
  belongs_to :daily_menu
  has_many :orders,  class_name: 'OrderItem', foreign_key: 'food_item_id', dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :course, presence: true
end
