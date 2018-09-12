class Admin::StationsController < Admin::BaseController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:id])
  end

end
