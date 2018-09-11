class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart.add_accessory(accessory.id.to_s)
    session[:cart] = @cart.contents
    quantity = @cart.contents[accessory.id.to_s]

    flash[:notice] = "You now have #{pluralize(quantity, "item")} of #{accessory.name} in your cart"
    redirect_to bike_shop_path
  end

  def index
  end

  def destroy
    @accessory = Accessory.find(params[:accessory_id])
    @cart.remove_accessory(@accessory.id.to_s)
    flash[:notice] = "Successfully removed #{view_context.link_to @accessory.name, accessory_path(@accessory)} from your cart."
    redirect_to '/cart'
  end
end
