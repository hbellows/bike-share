require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    it 'displays a list of my orders' do
      accessory1, accessory2, accessory3, accessory4 = create_list(:accessory, 4)

      user = create(:user)
      order1 = user.orders.create(status: 0)
      order1.order_accessories << [accessory1, accessory2, accessory3]

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content(user.username)
    end
  end
end
