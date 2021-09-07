class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_order_items = FoodItem.all.joins(:orders).where(order_items: {user: @user})
  end
end
