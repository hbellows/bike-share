require 'rails_helper'

describe 'visitor/user can view accessories in cart' do
  before(:each) do
    @accessory_1 = create(:accessory)
    @accessory_2 = create(:accessory, price: 11.00)
  end
  describe 'not logged in with accessories in cart' do
    xit 'should display accessories in cart' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to cart'
      end

      2.times do
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
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: #{@accessory_1.price + @accessory_2.price}")
    end
  end

  describe 'logged in with accessories in cart' do
    xit 'should display existing accessories in cart' do
      username = 'bikeshareuser'
      user = User.create(username: username, password: 'test')

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to cart'
      end

      2.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to cart'
        end
      end

      expect(page).to have_content(@accessory_1.title)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_2.title)
      expect(page).to have_content(@accessory_2.price)
      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: #{@accessory_1.price + @accessory_2.price}")

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: 'test'

      click_on "Log In"

      visit '/cart'

      expect(page).to have_content(@accessory_1.title)
      expect(page).to have_content(@accessory_1.price)
      expect(page).to have_content(@accessory_2.title)
      expect(page).to have_content(@accessory_2.price)
      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: 922.00")
    end
  end

  describe "visitor adds one more of the same accessory" do
    xit 'should be able to add an additional quantity' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to cart'
      end

      2.times do
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
      expect(page).to have_content("quantity: 2")
      expect(page).to have_content("Total: 922.00")

      visit bike_shop_path

      within("#accessory-#{@accessory_2.id}") do
        click_button 'Add to cart'
      end

      visit '/cart'

      expect(page).to have_content("quantity: 1")
      expect(page).to have_content("quantity: 3")
      expect(page).to have_content("Total: 933.00")
    end

    describe 'When a visitor adds accessories to cart' do
      it 'a message is displayed' do

        visit bike_shop_path

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to cart'
        end

        expect(page).to have_content("You now have 1 item of #{@accessory_2.name} in your cart")
      end
    end
  end
end
