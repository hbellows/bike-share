class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    redirect_to root_path unless @order.user_id == current_user.id
  end

  def update
    order = Order.find(params[:id])
    order.update(status: params[:status_update])
    order.save
    redirect_to admin_dashboard_path
  end
end
