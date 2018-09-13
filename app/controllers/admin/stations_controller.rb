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
    @station.installation_date = Date.strptime(params[:station][:installation_date], '%m/%d/%Y')
    if @station.save
      flash[:notice] = "#{@station.name} Created."
      redirect_to admin_stations_path
    else
      flash[:notice] = "Error - Could not create new station"
      redirect_to new_admin_station_path
    end
  end

  def edit
    @station = Station.friendly.find(params[:id])
  end

  def update
    station = Station.friendly.find(params[:id])
    station.update(station_params)
    station.update(installation_date: Date.strptime(params[:station][:installation_date], '%m/%d/%Y'))
    if station.save
      flash[:notice] = "#{station.name} updated!"
      redirect_to admin_station_path(station)
    else
      flash[:notice] = "All attributes must be present, update failed."
      redirect_to edit_admin_station_path(station)
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
