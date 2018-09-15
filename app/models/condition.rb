class Condition < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :max_temperature
  validates_presence_of :mean_temperature
  validates_presence_of :min_temperature
  validates_presence_of :mean_humidity
  validates_presence_of :mean_visibility
  validates_presence_of :mean_wind_speed
  validates_presence_of :precipitation

  def self.max_rides_high_temp_breakdown(min, max)
    Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("max_temperature between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) DESC").first.count
  end

  def self.min_rides_high_temp_breakdown(min, max)
    Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("max_temperature between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) ASC").first.count
  end

  def self.avg_rides_high_temp_breakdown(min, max)
    trip_count = Trip.select("trips.*, COUNT(trips.id) as count").joins("JOIN conditions ON trips.start_date=conditions.date").where("max_temperature between ? and ?", min, max).group("trips.id")
    trip_total = Trip.count
    (trip_count / trip_total.to_f) * 100
  end
end
