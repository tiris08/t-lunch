class Order < ApplicationRecord
  has_many :order_items, inverse_of: :order
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
  has_many :food_items, through: :order_items
  belongs_to :user
  belongs_to :daily_menu
  
end
