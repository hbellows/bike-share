require 'rails_helper'

describe "Admin Stations Index" do
  describe "Admin user visits stations index page" do
    it "shows edit and delete buttons next to each station" do
      admin = create(:user, role: 1)
      station = create(:station)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_stations_path

      # within("#station-#{station.id}") do
        expect(page).to have_content("Edit")
        expect(page).to have_content("Delete")
      # end
    end
  end
end
