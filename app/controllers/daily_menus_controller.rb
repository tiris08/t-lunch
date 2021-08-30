class DailyMenusController < ApplicationController
  def index
    @daily_menus = DailyMenu.last(10)
  end
end
