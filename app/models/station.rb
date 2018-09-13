class Station < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :dock_count, :numericality => { :greater_than_or_equal_to => 0 }
  validates_presence_of :city
  validates_presence_of :installation_date

  extend FriendlyId
  friendly_id :name, :use => :slugged

  def self.total_count
    count
  end

  def self.average_bikes_per_station
    average(:dock_count).round(1)
  end

  def self.most_bikes_per_station
    order(:dock_count).last
  end

  def self.least_bikes_per_station
    order(:dock_count).first
  end

  def self.newest_oldest
    order(:installation_date)
  end

  def number_rides_started
    Trip.where(start_station_id: id).count
  end

  def number_rides_ended
    Trip.where(end_station_id: id).count
  end

  def most_frequent_destination
    trip = Trip.select("end_station_id, COUNT(end_station_id) AS station_count")
             .where(start_station_id: id)
             .group(:end_station_id)
             .order("station_count DESC")
             .limit(1)
             .first
    Station.find(trip.end_station_id).name
  end

  def most_frequent_origination
    trip = Trip.select("start_station_id, COUNT(start_station_id) AS station_count")
             .where(end_station_id: id)
             .group(:start_station_id)
             .order("station_count DESC")
             .limit(1)
             .first
    Station.find(trip.start_station_id).name
  end

  def date_for_most_trips_started
    trip = Trip.select("start_date, COUNT(start_date) AS date_count")
             .where(start_station_id: id)
             .group(:start_date)
             .order("date_count DESC")
             .limit(1)
             .first
    trip.start_date.to_date
  end

  def top_starting_user_zipcode
    Trip.select("zip_code, COUNT(zip_code) AS zip_count")
      .where(start_station_id: id)
      .group(:zip_code)
      .order("zip_count DESC")
      .limit(1)
      .first
      .zip_code
  end

  def top_starting_bike_id
    Trip.select("bike_id, COUNT(bike_id) AS bike_count")
      .where(start_station_id: id)
      .group(:bike_id)
      .order("bike_count DESC")
      .limit(1)
      .first
      .bike_id
  end
end
