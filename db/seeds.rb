# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

station_csv = Rails.root.join('lib', 'seeds', 'station.csv')
trip_csv = Rails.root.join('lib', 'seeds', 'trip.csv')
weather_csv = Rails.root.join('lib', 'seeds', 'weather.csv')

# Load stations in
puts "Seeding Stations table"
CSV.foreach(station_csv, headers: true, header_converters: :symbol) do |row|
  Station.create!(
    id:                row[:id],
    dock_count:        row[:dock_count],
    name:              row[:name],
    city:              row[:city],
    installation_date: Date.strptime(row[:installation_date], '%m/%d/%Y')
  )
end

# Load conditions in
puts "Seeding conditions table"
CSV.foreach(weather_csv, headers: true, header_converters: :symbol) do |row|
  Condition.create!(
    date:             Date.strptime(row[:date], '%m/%d/%Y'),
    max_temperature:  row[:max_temperature_f].to_f,
    mean_temperature: row[:mean_temperature_f].to_f,
    min_temperature:  row[:min_temperature_f].to_f,
    mean_humidity:    row[:mean_humidity].to_f,
    mean_visibility:  row[:mean_visibility_miles].to_f,
    mean_wind_speed:  row[:mean_wind_speed_mph].to_f,
    precipitation:    row[:precipitation_inches].to_f
  )
end

# Load trips in with counter
row_count = 0
puts "Seeding Trips table"
CSV.foreach(trip_csv, headers: true, header_converters: :symbol) do |row|
  Trip.create!(
    duration:          row[:duration].to_i,
    start_date:        Date.strptime(row[:start_date], '%m/%d/%Y'),
    start_station_id:  row[:start_station_id].to_i,
    end_date:          Date.strptime(row[:end_date], '%m/%d/%Y'),
    end_station_id:    row[:end_station_id].to_i,
    bike_id:           row[:bike_id].to_i,
    subscription_type: row[:subscription_type].to_i,
    zip_code:          row[:zip_code].to_i
  )
  row_count += 1
  break if row_count >= 5000
end
