module Helpers
  module DailyMenu
    def daily_menu_with_food_items(food_items_count: 9)
      FactoryBot.create(:daily_menu) do |daily_menu|
        FactoryBot.create_list(:food_item, food_items_count, daily_menu: daily_menu)
      end
    end
  end
end
