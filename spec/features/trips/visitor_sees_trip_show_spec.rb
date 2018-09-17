require 'rails_helper'

feature 'When a visitor visits the trip show page' do
  scenario 'they see all attributes of that trip' do
    station_1, station_2 = create_list(:station, 2)

    trip_1 = create(:trip, start_station_id: station_1.id, end_station_id: station_2.id)

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
