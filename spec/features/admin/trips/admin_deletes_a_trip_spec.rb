require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit trips index' do
    it 'allows me to delete a trip' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1, station2 = create_list(:station, 2)
      trip = create(:trip, start_station_id: station1.id, end_station_id: station2.id)

      visit admin_trips_path

      within("#trip-#{trip.id}") do
        click_link 'Delete'
      end

      expect(current_path).to eq(admin_trips_path)
      expect(page).to have_content('Trip deleted.')
      expect(page).to_not have_content(trip.id)
    end
  end
end
