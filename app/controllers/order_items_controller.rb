class OrderItemsController < ApplicationController
  def new
    @order_items = Array.new(3, OrderItem.new)
    @courses = ["First", "Main", "Drink"]
    @daily_menu = DailyMenu.find(params[:daily_menu_id])
  end

  def create
    begin
      OrderItem.transaction do
        @order_items = OrderItem.create!(order_params)
      end
    rescue ActiveRecord::RecordInvalid 
      @order_items = Array.new(3, OrderItem.new)
      @courses = ["First", "Main", "Drink"]
      @daily_menu = DailyMenu.find(params[:daily_menu_id])
      flash[:alert] = "You must select three items. Try again."
      render :new
    else
      redirect_to daily_menu_path(DailyMenu.find(params[:daily_menu_id]))
      flash[:notice] = "Your order was successfuly created."
    end
  end

  private

  def order_params
    params.permit(order_items: [:food_item_id, :user_id]).require(:order_items)
  end
end