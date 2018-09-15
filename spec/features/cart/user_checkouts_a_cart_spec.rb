require 'rails_helper'

describe 'As a user' do
  describe 'When I checkout my cart' do
    it 'I see my dashboard page and the order in my order history' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      accessory1 = create(:accessory)
      accessory2 = create(:accessory)

      visit bike_shop_path

      within("#accessory-#{accessory1.id}") do
        click_button 'Add to Cart'
      end

      within("#accessory-#{accessory2.id}") do
        click_button 'Add to Cart'
      end

      within("#accessory-#{accessory2.id}") do
        click_button 'Add to Cart'
      end

      visit cart_path

      fill_in :street_address, with: '999 Street Ave'
      fill_in :city, with: 'Denver'
      select 'Colorado', from: :state
      fill_in :zip_code, with: 80401

      click_button 'Checkout'

      order = user.orders[0]

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Order ##{order.id}")
    end
  end
end
