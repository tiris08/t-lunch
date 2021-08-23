class FoodItem < ApplicationRecord
  enum course: [:first_course, :main_course, :drink]
  belongs_to :daily_menu
end
