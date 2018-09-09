require 'rails_helper'

feature 'visitor adds accessories to cart' do
  before(:each) do
    @accessory_1 = create(:accessory)
    @accessory_2 = create(:accessory, price: 11.00)
  end

  visit bike_shop_path

  within("#accessory-#{@accessory_1.id}") do
    click_button 'Add to cart'
  end

  2.times do
    within("#accessory-#{@accessory_2.id}") do
      click_button 'Add to cart'
    end
  end

  scenario 'not logged in with accessories in cart' do
    it 'should display accessories in cart' do

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

  scenario 'logged in with accessories in cart' do
    it 'should display existing accessories in cart' do
      username = 'bikeshareuser'
      user = User.create(username: username, password: 'test')

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

  scenario "visitor adds one more of the same accessory" do

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
end
