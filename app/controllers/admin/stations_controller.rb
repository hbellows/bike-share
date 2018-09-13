class Admin::StationsController < Admin::BaseController
  # before_action :set_station, only: [:show, :create, :new]

  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:id])
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice] = "#{@station.name} Created."
      redirect_to admin_stations_path
    else
      flash[:notice] = "Error - Could not create new station"
      redirect_to new_admin_station_path
    end
  end

  private

    def station_params
      params.require(:station).permit(:name, :dock_count, :city, :installation_date)
    end

    def set_station
      @station = Station.friendly.find(params[:id])
    end
end
