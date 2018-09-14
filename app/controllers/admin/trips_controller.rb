class Admin::TripsController < Admin::BaseController
  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @trip = Trip.new
    @stations = Station.all.map { |s| [s.name, s.id] }
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.start_date = Date.strptime(trip_params[:start_date], '%m/%d/%Y')
    @trip.end_date = Date.strptime(trip_params[:end_date], '%m/%d/%Y')
    if @trip.save
      flash[:notice] = 'New Trip added!'
      redirect_to trip_path(@trip)
    else
      flash[:notice] = 'Trip was not created.'
      redirect_to new_admin_trip_path
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :start_station_id, :end_station_id, :bike_id, :subscription_type, :zip_code)
  end
end
