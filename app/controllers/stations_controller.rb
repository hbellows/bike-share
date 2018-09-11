class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:id])
  end

  def dashboard
    @stations = Station.all
    @stations_count = @stations.total_count
    @average_bikes_per_station = @stations.average_bikes_per_station
    @most_bikes_per_station = @stations.most_bikes_per_station.dock_count
  end
end
