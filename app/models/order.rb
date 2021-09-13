class Order < ApplicationRecord
  belongs_to :user
  belongs_to :daily_menu
  has_many :order_items
  has_many :food_items, through: :order_items
end
