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
    @station_with_most_bikes = @stations.most_bikes_per_station.name
    @most_bikes = @stations.most_bikes_per_station.dock_count
    @least_bikes = @stations.least_bikes_per_station.dock_count
    @station_with_least_bikes = @stations.least_bikes_per_station.name
  end
end
