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

  def self.duration_info
    [maximum(:duration), average(:duration), minimum(:duration)]
  end

  def self.station_info
    [self.most_frequent_start_station, self.most_frequent_end_station]
  end

  def self.most_frequent_start_station
    station = select('start_station_id, COUNT(start_station_id) AS start_station_count')
    .group(:start_station_id)
    .order('start_station_count DESC')
    .limit(1)
    .first
    Station.find(station.start_station_id)
  end

  def self.most_frequent_end_station
    station_id = select('end_station_id, COUNT(end_station_id) AS end_station_count')
    .group(:end_station_id)
    .order('end_station_count DESC')
    .limit(1)
    .first
    Station.find(station_id.end_station_id)
  end

  def self.rides_per_month
    group("date_trunc('month', start_date)").order('count_all DESC').count
  end

  def self.rides_per_year
    group("date_trunc('year', start_date)").order('count_all DESC').count
  end


end
