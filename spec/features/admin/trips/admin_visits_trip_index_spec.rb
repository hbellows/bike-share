require 'rails_helper'

describe 'As an admin' do
  describe 'When I visist /admin/trips' do
    before(:each) do
      @admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      @station1 = create(:station)
      @station2 = create(:station)
      @trip1, @trip2, @trip3 = create_list(:trip, 3, start_station_id: @station1.id, end_station_id: @station2.id)
    end
    it 'lists all trips and attributes a visitor would see' do
      visit admin_trips_path

      within("#trip-#{@trip1.id}") do
        expect(page).to have_link("##{@trip1.id}", href: admin_trip_path(@trip1))
        expect(page).to have_content(@trip1.duration)
        expect(page).to have_content(@trip1.start_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@trip1.end_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@station1.name)
        expect(page).to have_content(@station2.name)
        expect(page).to have_content(@trip1.bike_id)
        expect(page).to have_content(@trip1.subscription_type)
        expect(page).to have_content(@trip1.zip_code)
      end
      within("#trip-#{@trip2.id}") do
        expect(page).to have_link("##{@trip2.id}", href: admin_trip_path(@trip2))
        expect(page).to have_content(@trip2.duration)
        expect(page).to have_content(@trip2.start_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@trip2.end_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@station1.name)
        expect(page).to have_content(@station2.name)
        expect(page).to have_content(@trip2.bike_id)
        expect(page).to have_content(@trip2.subscription_type)
        expect(page).to have_content(@trip2.zip_code)
      end
      within("#trip-#{@trip3.id}") do
        expect(page).to have_link("##{@trip3.id}", href: admin_trip_path(@trip3))
        expect(page).to have_content(@trip3.duration)
        expect(page).to have_content(@trip3.start_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@trip3.end_date.strftime('%m/%d/%Y'))
        expect(page).to have_content(@station1.name)
        expect(page).to have_content(@station2.name)
        expect(page).to have_content(@trip3.bike_id)
        expect(page).to have_content(@trip3.subscription_type)
        expect(page).to have_content(@trip3.zip_code)
      end
    end
    it 'has links for admin to edit and delete' do
      visit admin_trips_path

      within("#trip-#{@trip1.id}") do
        expect(page).to have_link('Edit', href: edit_admin_trip_path(@trip1))
        expect(page).to have_link('Delete', href: admin_trip_path(@trip1))
      end
    end
    it 'has a link for an admin to create a new trip' do
      visit admin_trips_path

      expect(page).to have_link('Add New Trip', href: new_admin_trip_path)
    end
  end
end
