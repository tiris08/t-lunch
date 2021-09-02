class DailyMenusController < ApplicationController
  def index
    @daily_menus = DailyMenu.order(created_at: :desc).page(params[:page])
  end

  def show
    @daily_menu = DailyMenu.find(params[:id])
    @user_order_items = @daily_menu.food_items.joins(:orders).where(order_items: { user: current_user })
    @user_order_cost = @user_order_items.pluck(:price).sum
  end
end
