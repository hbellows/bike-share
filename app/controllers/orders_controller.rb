class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    redirect_to root_path unless @order.user_id == current_user.id
  end
end
