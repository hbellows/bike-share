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
    breakdown = Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("#{attribute} between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) DESC").first
    if breakdown != nil
      breakdown.count
    else
      0
    end
  end

  def self.min_rides_breakdown(min, max, attribute)
    breakdown = Trip.select("start_date, count(trips.id) as count").
    joins("join conditions ON conditions.date=trips.start_date").
    where("#{attribute} between ? and ?", min, max).
    group(:start_date).
    order("count(trips.id) ASC").first
    if breakdown != nil
      breakdown.count
    else
      0
    end
  end

  def self.avg_rides_breakdown(min, max, attribute)
    trip_count = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).length
    trip_total = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).size.values.sum
    if trip_total > 0 && trip_count > 0
      trip_total / trip_count.to_f
    else
      0
    end
  end

  def self.max_temp_breakdown
    ranges = {'40s'=>{min: 40, max: 49.9},'50s'=>{min: 50, max: 59.9},'60s'=>{min: 60, max: 69.9},'70s'=>{min: 70, max: 79.9},'80s'=>{min: 80, max: 89.9},'90s'=>{min: 90, max: 100}}
    max_temp_values= Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    ranges.each do |temp_range, min_max|
      max_temp_values['max_rides'][temp_range] = Condition.max_rides_breakdown(min_max[:min], min_max[:max], 'max_temperature')
      max_temp_values['avg_rides'][temp_range] = Condition.avg_rides_breakdown(min_max[:min], min_max[:max], 'max_temperature')
      max_temp_values['min_rides'][temp_range] = Condition.min_rides_breakdown(min_max[:min], min_max[:max], 'max_temperature')
    end
    max_temp_values
  end

  def self.precip_breakdown
    ranges = {'half'=>{min: 0, max: 0.49},'one'=>{min: 0.5, max: 0.99},'one_half'=>{min: 1, max: 1.49},'two'=>{min: 1.5, max: 1.99},'two_half'=>{min: 2, max: 2.49},'three'=>{min: 2.5, max: 2.99},'three_half'=>{min: 3, max: 3.49}}
    precipitation_values = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    ranges.each do |precip_range, min_max|
      precipitation_values['max_rides'][precip_range] = Condition.max_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
      precipitation_values['avg_rides'][precip_range] = Condition.avg_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
      precipitation_values['min_rides'][precip_range] = Condition.min_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
    end
    precipitation_values
  end

  def self.wind_breakdown
    ranges = {'four'=>{min: 0, max: 3.99},'eight'=>{min: 4, max: 7.99},'twelve'=>{min: 8, max: 11.99},'sixteen'=>{min: 12, max: 15.99},'twenty'=>{min: 16, max: 19.99},'twenty_four'=>{min: 20, max: 24}}
    wind_speed_values = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    ranges.each do |temp_range, min_max|
      wind_speed_values['max_rides'][temp_range] = Condition.max_rides_breakdown(min_max[:min], min_max[:max], 'mean_wind_speed')
      wind_speed_values['avg_rides'][temp_range] = Condition.avg_rides_breakdown(min_max[:min], min_max[:max], 'mean_wind_speed')
      wind_speed_values['min_rides'][temp_range] = Condition.min_rides_breakdown(min_max[:min], min_max[:max], 'mean_wind_speed')
    end
    wind_speed_values
  end
  
  def self.visibility_breakdown
    ranges = {'four'=>{min: 0, max: 3.99},'eight'=>{min: 4, max: 7.99},'twelve'=>{min: 8, max: 11.99},'sixteen'=>{min: 12, max: 15.99},'twenty'=>{min: 16, max: 19.99},'twenty_four'=>{min: 20, max: 24}}
    visibility_values = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    ranges.each do |visibility_range, min_max|
      visibility_values['max_rides'][visibility_range] = Condition.max_rides_breakdown(min_max[:min], min_max[:max], 'mean_visibility')
      visibility_values['avg_rides'][visibility_range] = Condition.avg_rides_breakdown(min_max[:min], min_max[:max], 'mean_visibility')
      visibility_values['min_rides'][visibility_range] = Condition.min_rides_breakdown(min_max[:min], min_max[:max], 'mean_visibility')
    end
    visibility_values
  end
end
