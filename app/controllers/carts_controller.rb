class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart.add_accessory(accessory.id.to_s)
    session[:cart] = @cart.contents
    quantity = @cart.contents[accessory.id.to_s]
    if params[:add] == 'adding one'
      redirect_to '/cart'
    else
      flash[:notice] = "You now have #{pluralize(quantity, "item")} of #{accessory.name} in your cart"
      redirect_to bike_shop_path
    end
  end

  def index
  end

  def destroy
    accessory = Accessory.find(params[:accessory_id]) unless params[:accessory_id] == nil
    if params[:remove] == 'removing one'
      @cart.decrease_quantity(accessory.id.to_s)
      redirect_to '/cart'
    elsif params[:checkout] == 'checkout' && current_user && @cart.contents == {}
      flash[:notice] = "Add items to cart to checkout"
      redirect_to root_path
    elsif params[:checkout] == 'checkout' && current_user
      @cart.checkout(current_user)
      @cart.contents.clear
      total = params[:total]
      flash[:notice] = "Successfully submitted your order totalling #{total}"
      redirect_to dashboard_path
    elsif params[:checkout] == 'checkout'
      flash[:notice] = "Need to log in to checkout"
      redirect_to login_path
    else
      @cart.remove_accessory(accessory.id.to_s)
      flash[:notice] = "Successfully removed #{view_context.link_to accessory.name, accessory_path(accessory)} from your cart."
      redirect_to '/cart'
    end
  end

end
