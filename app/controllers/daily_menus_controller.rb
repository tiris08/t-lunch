class DailyMenusController < ApplicationController
  def index
    @daily_menus = DailyMenu.last(10)
  end

  def show
    @daily_menu = DailyMenu.find(params[:id])
    @daily_menu_order = DailyMenu.includes(:users)
  end
end
