class Admin::StationsController < Admin::BaseController
  # before_action :set_station, only: [:show, :update, :edit, :create, :new]

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
  
  def edit
    @station = Station.friendly.find(params[:id])
    @admin = current_user.role
  end

  def update
    station = Station.friendly.find(params[:id])
    station.update(station_params)
    if station.save
      flash[:notice] = "#{station.name} updated!"
      redirect_to admin_station_path(station)
    else
      flash[:notice] = "All attributes must be present, update failed."
      redirect_to edit_admin_station_path(station)
    end
  end

  def destroy
    @station = Station.friendly.find(params[:id])
    @station.destroy
    flash[:notice] = "Station deleted."
    redirect_to admin_stations_path
  end

  private

    def station_params
      params.require(:station).permit(:name, :dock_count, :city, :installation_date)
    end

    # def set_station
    #   @station = Station.friendly.find(params[:id])
    # end
end
