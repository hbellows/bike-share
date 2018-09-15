class Admin::AccessoriesController < Admin::BaseController
  def index
  	@accessories = Accessory.order(:name)
  end

  def update
  	accessory = Accessory.find(params[:id])
  	if params[:retired?]
  		accessory.update(retired?: params[:retired?])
  		accessory.save
  		redirect_to admin_bike_shop_path
  	end
  end
end
