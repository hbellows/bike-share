require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit /admin/trips/edit/:id' do
    it 'allows me to edit an existing trip' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      station1 = create(:station, name: 'Start Station')
      station2 = create(:station, name: 'End Station')
      trip = create(:trip, start_station_id: station1.id, end_station_id: station2.id)

      visit edit_admin_trip_path(trip)

      fill_in :trip_duration, with: '120'
      fill_in :trip_start_date, with: '09/13/2018'
      fill_in :trip_end_date, with: '09/13/2018'
      select station1.name, from: :trip_start_station_id
      select station2.name, from: :trip_end_station_id
      fill_in :trip_bike_id, with: 100
      fill_in :trip_subscription_type, with: 0
      fill_in :trip_zip_code, with: 80401

      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(Trip.last))
      expect(page).to have_content('Trip updated!')
      expect(page).to have_content("Duration: #{Trip.last.duration / 60} minutes")
      expect(page).to have_content("Start Station: #{station1.name}")
      expect(page).to have_content("End Station: #{station2.name}")
      expect(page).to have_content("Start Date: #{Trip.last.start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("End Date: #{Trip.last.end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("Subscription Type: #{Trip.last.subscription_type}")
      expect(page).to have_content("Zip Code: #{Trip.last.zip_code}")
    end
  end
end
