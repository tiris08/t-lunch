class DailyMenusController < ApplicationController
  def index
    @daily_menus = DailyMenu.order(created_at: :desc).page(params[:page])
  end

  def show
    @daily_menu = DailyMenu.find(params[:id])
    @user_order = FoodItem.joins(:orders, :daily_menu).where(order_items: {user_id: current_user.id}, 
                                                             daily_menu: {id: params[:id]})
    @user_order_cost = 0
    @user_order.each {|item| @user_order_cost += item.price }
  end
end
