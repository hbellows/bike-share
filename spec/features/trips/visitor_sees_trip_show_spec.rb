require 'rails_helper'

feature 'When a visitor visits the trip show page' do
  scenario 'they see all attributes of that trip' do
    station_1 = Station.create(name: 'San Jose Diridon Caltrain Station', dock_count: 27, city: 'San Jose', installation_date: Date.new(2014, 10, 17))
    station_2 = Station.create(name: 'Redwood City Muni', dock_count: 37, city: 'Redwood City', installation_date: Date.new(2016, 11, 26))

    trip_1 = Trip.create!(duration: 63, start_date: Date.new(2013, 8, 29), end_date: Date.new(2013, 8, 29), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 520, subscription_type: 0, zip_code: 98712)

    visit trip_path(trip_1)

    expect(page).to have_content("Duration: #{trip_1.duration / 60} minutes")
    expect(page).to have_content("Start Date: #{trip_1.start_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("End Date: #{trip_1.end_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("Start Station: #{trip_1.start_station.name}")
    expect(page).to have_content("End Station: #{trip_1.end_station.name}")
    expect(page).to have_content("Bike ID: #{trip_1.bike_id}")
    expect(page).to have_content("Subscription Type: #{trip_1.subscription_type}")
    expect(page).to have_content("Zip Code: #{trip_1.zip_code}")

  end
end
