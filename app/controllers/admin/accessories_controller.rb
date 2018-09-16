class Admin::AccessoriesController < Admin::BaseController
  def index
  	@accessories = Accessory.order(:name)
  end

  def new
  	@accessory = Accessory.new
  end

  def create
  	@accessory = Accessory.new(accessory_params)
  	if @accessory.save
  		flash[:notice] = "#{@accessory.name} created!"
  		redirect_to accessory_path(@accessory)
  	else
  		flash[:notice] = 'Accessory could not be created.'
  		redirect_to new_admin_accessory_path
  	end
  end

  def update
  	accessory = Accessory.find(params[:id])
  	if params[:retired?]
  		accessory.update(retired?: params[:retired?])
  		accessory.save
  		redirect_to admin_bike_shop_path
  	end
  end

  private

  def accessory_params
  	params.require(:accessory).permit(:name, :description, :price)
  end
end
