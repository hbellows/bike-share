require 'rails_helper'

describe 'As a visitor' do
	describe 'When I try to checkout a cart' do
		it "visitor clicks on checkout with items in the cart and recieves message" do
			accessory_1 = create(:accessory, price: 25)
    	accessory_2 = create(:accessory, price: 15)

      visit bike_shop_path

      within("#accessory-#{accessory_1.id}") do
        click_button "Add to Cart"
      end

      2.times do
        within("#accessory-#{accessory_2.id}") do
          click_button "Add to Cart"
        end
      end

      visit '/cart'

      click_button "Checkout"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Need to log in to checkout")
    end
	end	
end