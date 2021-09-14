class OrdersController < ApplicationController
  before_action :verify_is_not_admin!
  
  def new
    @order = Order.new
    3.times {@order.order_items.build}
    @course = ["First", "Main", "Drink"]
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to daily_menus_path(DailyMenu.find(params[:daily_menu_id])), notice: "Your order was successfully created"
    else
      render :new
    end 
  end
  
  private

  def order_params
    params.require(:order).permit(:user_id, :daily_menu_id, order_items_attributes: [:id, :food_item_id, :order_id, :_delete])
  end

  def verify_is_not_admin!
    if current_user && current_user.is_admin?
      redirect_to admin_root_path, alert: "You don't belong there"
    end
  end
end
