require 'rails_helper'

describe 'visitor/user can view accessories in cart' do
  before(:each) do
    @accessory_1 = create(:accessory, price: 10.00)
    @accessory_2 = create(:accessory, price: 11.00)
  end
  describe 'not logged in with accessories in cart' do
    it 'should display accessories in cart' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      2.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $32.00")
    end
  end

  describe 'logged in with accessories in cart' do
    it 'should display existing accessories in cart' do
      username = 'bikeshareuser'
      user = User.create(username: username, password: 'test')

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      2.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $32.00")

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: 'test'

      click_on "Log In"

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $32.00")
    end
  end

  describe "visitor adds one more of the same accessory" do
    it 'should be able to add an additional Quantity' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end


      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Total: $10.00")

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_1.image)
      expect(page).to_not have_content("Quantity: 1")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $20.00")
    end

    describe 'When a visitor adds accessories to cart' do
      it 'a message is displayed' do

        visit bike_shop_path

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 1 item of #{@accessory_2.name} in your cart")
      end
      it 'a message correctly increments for multiple accessories' do

        visit bike_shop_path

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 1 item of #{@accessory_2.name} in your cart")

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 2 items of #{@accessory_2.name} in your cart")
      end
      it 'total number of accessories in cart increments' do

        visit bike_shop_path

        expect(page).to have_content("Cart: 0")

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("Cart: 1")
      end
    end
  end
end
