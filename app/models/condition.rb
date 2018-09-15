class Condition < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :max_temperature
  validates_presence_of :mean_temperature
  validates_presence_of :min_temperature
  validates_presence_of :mean_humidity
  validates_presence_of :mean_visibility
  validates_presence_of :mean_wind_speed
  validates_presence_of :precipitation

  def self.max_rides_breakdown(min, max, attribute)
    Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("#{attribute} between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) DESC").first.count
  end

  def self.min_rides_breakdown(min, max, attribute)
    Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("#{attribute} between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) ASC").first.count
  end

  def self.avg_rides_breakdown(min, max, attribute)
    trip_count = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).length
    trip_total = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).size.values.sum
    trip_total / trip_count
  end
end
