# As an admin user,
# When I visit "/admin/dashboard",
# I see a link for viewing all accessories,
# When I click that link,
# My current path should be "/admin/bike-shop",
# I see a table with all accessories (active and inactive)
#
# Each accessory should have:
#
# A thumbnail of the image
# Description
# Status
# Ability to Edit accessory
# Ability to Retire/Reactivate accessory

require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit /admin/dashboard' do
    it 'shows me a link to view all accessories' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_link 'Accessories'

      expect(current_path).to eq(admin_bike_shop_path)
    end
  end
end
