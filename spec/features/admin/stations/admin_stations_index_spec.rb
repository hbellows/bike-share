require 'rails_helper'

describe "Admin Stations Index" do
  describe "Admin user visits stations index page" do
    it "shows edit and delete buttons next to each station" do
      admin = create(:user, role: 1)
      station1 = create(:station)
      station2 = create(:station)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_stations_path

      expect(page).to have_content("Add Station")

      within("#station-#{station1.id}") do
        expect(page).to have_content(station1.name)
        expect(page).to have_content(station1.dock_count)
        expect(page).to have_content(station1.city)
        expect(page).to have_content(station1.installation_date.strftime('%m/%d/%Y'))
        expect(page).to have_content("Edit")
        expect(page).to have_content("Delete")
      end

      within("#station-#{station2.id}") do
        expect(page).to have_content(station2.name)
        expect(page).to have_content(station2.dock_count)
        expect(page).to have_content(station2.city)
        expect(page).to have_content(station2.installation_date.strftime('%m/%d/%Y'))
        expect(page).to have_content("Edit")
        expect(page).to have_content("Delete")
      end
    end
    it 'allows an admin to create a new station' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_station_path
      fill_in :station_name, with: "New Station"
      fill_in :station_dock_count, with: 0
      fill_in :station_city, with: "New City"
      fill_in :station_installation_date, with: "2018/09/12"

      click_on "Create Station"

      expect(current_path).to eq(admin_stations_path)
      expect(page).to have_content("New Station")
      expect(page).to have_content("New City")
      expect(page).to have_content("09/12/2018")
    end
  end
end
