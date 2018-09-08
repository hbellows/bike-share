require 'rails_helper'

feature 'When a visitor visits the trip show page' do
  scenario 'they see all attributes of that trip' do
   station_1 = Station.create(name: 'San Jose Diridon Caltrain Station', dock_count: 27, city: 'San Jose', installation_date: '8/6/2013')
   station_2 = Station.create(name: 'San Jose Civic Center', dock_count: 15	, city: 'San Jose', installation_date: '8/5/2013')
   trip = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_name: station_1.name, end_date: "8/29/2013 14:14", end_station_name: station_2.name, bike_id: 520, subscription_type: 'premium')

   visit "/#{trip.id}"

   expect(page).to have_content(trip.name)
   expect(page).to have_content(trip.start_date)
   expect(page).to have_content(trip.start_station_name)
   expect(page).to have_content("Station ID: #{trip.start_station_id}")
   expect(page).to have_content(trip.end_date)
   expect(page).to have_content(trip.end_station_name)
   expect(page).to have_content(trip.bike_id)
  end
end
