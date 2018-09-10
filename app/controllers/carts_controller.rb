class CartsController < ApplicationController

  def create
    @accessory = Accessory.find(params[:accessory_id])
    flash[:notice] = "You now have 1 item of #{@accessory.name} in your cart"
    redirect_to bike_shop_path
  end
end
