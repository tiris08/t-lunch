class Order < ApplicationRecord
  belongs_to :daily_menu
  belongs_to :user
end
