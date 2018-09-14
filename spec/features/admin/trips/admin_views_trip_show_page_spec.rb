require 'rails_helper'

describe 'As an admin' do
  describe 'When I visist /trip/:id' do
    it 'shows me buttons to edit or delete that trip' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1, station2 = create_list(:station, 2)
      trip = create(:trip, start_station_id: station1.id, end_station_id: station2.id)

      visit trip_path(trip)

      expect(page).to have_link('Edit', href: edit_admin_trip_path(trip))
      expect(page).to have_link('Delete', href: admin_trip_path(trip))
    end
  end
end
