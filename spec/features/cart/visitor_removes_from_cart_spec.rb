require 'rails_helper'

describe 'visitor removes accessories from cart' do
  before(:each) do
    @accessory_1 = create(:accessory, price: 10)
    @accessory_2 = create(:accessory, price: 11)
  end

  describe 'removes accessories in cart' do
    it 'should show cart without item that was removed' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      3.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      within("#accessory-#{@accessory_2.id}") do
        click_button 'Remove'
      end

      expect(page).to have_content("Successfully removed #{@accessory_2.name} from your cart.")
      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to_not have_content(@accessory_2.price)

      click_on @accessory_2.name

      expect(current_path).to eq(accessory_path(@accessory_2))
    end
  end
  describe "visitor decreases one of the same accessory" do
    it 'should show cart with accessory decreased' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      3.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_2.name)
      expect(page).to have_content(@accessory_2.price)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Quantity: 3")
      expect(page).to have_content("Total: $43.00")

      within("#accessory-#{@accessory_2.id}") do
        click_button 'decrease quantity'
      end

      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: $32.00")
    end
  end
end
