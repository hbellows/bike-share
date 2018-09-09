require 'rails_helper'

describe 'visitor removes accessories from cart' do
  before(:each) do
    @accessory_1 = create(:accessory)
    @accessory_2 = create(:accessory, price: 11.00)
  end

  describe 'removes accessories in cart' do
    it 'should show cart without item that was removed' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to cart'
      end

      3.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to cart'
        end
      end

      visit '/cart'

      within("#accessory-#{@accessory_2.id}") do
        click_link 'Remove'
      end

      expect(flash[:alert]).to eq "Successfully removed #{@accessory_2.title} from your cart."
      expect(page).to have_content(@accessory_1.title)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to_not have_content(@accessory_2.price)

      click_on @accessory_2.title

      expect(current_path).to eq(accessory_path(@accessory_2))
    end
  end
  describe "visitor decreases one of the same accessory" do
    it 'should show cart with accessory decreased' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to cart'
      end

      3.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.title)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_2.title)
      expect(page).to have_content(@accessory_2.price)
      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 3")
      expect(page).to have_content("Total: 933.00")

      within("#accessory-#{@accessory_2.id}") do
        click_button 'decrease quantity'
      end

      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: 922.00")
    end
  end
end
