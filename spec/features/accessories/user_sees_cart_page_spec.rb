require 'rails_helper'

describe "user visits their cart page" do
  before(:each) do
    @user = User.create(username: 'theperson', password: '1234')
    @accessory1 = Accessory.create(title: 'title_1', description: 'desc1', price: 11.00)
    accessory_2 = Accessory.create(title: 'title_2', description: 'desc1', price: 34.41)
    accessory_3 = Accessory.create(title: 'title_3', description: 'desc1', price: 17.88)
    accessory_4 = Accessory.create(title: 'title_4', description: 'desc1', price: 45.21)
    accessory_5 = Accessory.create(title: 'title_5', description: 'desc1', price: 34.41)
    accessory_6 = Accessory.create(title: 'title_6', description: 'desc1', price: 27.41)
    accessory_7 = Accessory.create(title: 'title_7', description: 'desc1', price: 34.41)
    accessory_8 = Accessory.create(title: 'title_8', description: 'desc1', price: 36.32)
    accessory_9 = Accessory.create(title: 'title_9', description: 'desc1', price: 34.41)
    accessory_10 = Accessory.create(title: 'title_10', description: 'desc1', price: 42.45)
    accessory_11 = Accessory.create(title: 'title_11', description: 'desc1', price: 34.41)
    @accessory_12 = Accessory.create(title: 'title_12', description: 'desc1', price: 10.00)

    visit bike_shop_path

    within(".accessory-#{@accessory_1.id}") do
      click_button "Add to Cart"
    end

    within(".accessory-#{@accessory_12.id}") do
      click_button "Add to Cart"
    end

    within(".accessory-#{@accessory_12.id}") do
      click_button "Add to Cart"
    end
  end
  it "shows all accessories that have been added to cart" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit cart_path

    subtotal_12 = (@accessory_12.price * 2)
    subtotal_1 = @accessory_1.price
    grand_total = subtotal_12 + subtotal_1
    expect(page).to have_content(@accessory_12.title)
    expect(page).to have_content("Price: #{@accessory_12.price}")
    expect(page).to have_content(@accessory_1.title)
    expect(page).to have_content("Price: #{@accessory_1.price}")
    expect(page).to have_content("Subtotal: #{subtotal_12}")
    expect(page).to have_content("Subtotal: #{subtotal_1}")
    expect(page).to have_content("Grand Total: #{grand_total}")
    expect(page).to have_button("Checkout")
  end
end
