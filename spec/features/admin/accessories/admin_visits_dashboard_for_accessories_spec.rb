require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit /admin/dashboard' do
    it 'shows me a link to view all accessories and takes me to that accessory page' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_link 'Accessories'

      expect(current_path).to eq(admin_bike_shop_path)
    end
  end
end
