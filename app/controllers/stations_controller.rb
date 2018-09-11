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
  end
end
