class Admin::DailyMenusController < Admin::BaseController
  def index
    @daily_menus = DailyMenu.order(created_at: :desc).page(params[:page])
  end

  def new
    @daily_menu = DailyMenu.new
    @daily_menu.food_items.build
  end

  def create
  end
end 
