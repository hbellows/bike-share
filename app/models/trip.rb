class Trip < ApplicationRecord
  validates_presence_of :duration
  validates_presence_of :start_date
  validates_presence_of :start_station_id
  validates_presence_of :end_date
  validates_presence_of :end_station_id
  validates_presence_of :bike_id
  validates_presence_of :subscription_type
  validates_presence_of :zip_code

  def start_station
    Station.find(start_station_id)
  end

  def end_station
    Station.find(end_station_id)
  end


end
