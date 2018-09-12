require 'rails_helper'

describe "user visits their cart page" do
  before(:each) do
    @user = create(:user)
    @accessory_1 = create(:accessory, price: 25)
    @accessory_2 = create(:accessory, price: 15)
  end

  it "shows all accessories that have been added to cart" do

    visit bike_shop_path

    within("#accessory-#{@accessory_1.id}") do
      click_button "Add to Cart"
    end

    2.times do
      within("#accessory-#{@accessory_2.id}") do
        click_button "Add to Cart"
      end
    end

    visit '/cart'

    subtotal_2 = (@accessory_2.price * 2)
    subtotal_1 = @accessory_1.price
    grand_total = subtotal_2 + subtotal_1
    expect(page).to have_content(@accessory_1.name)
    expect(page).to have_content("Price: $#{@accessory_1.price}.00")
    expect(page).to have_content("Subtotal: $#{subtotal_1}.00")
    expect(page).to have_content(@accessory_2.name)
    expect(page).to have_content("Price: $#{@accessory_2.price}.00")
    expect(page).to have_content("Subtotal: $#{subtotal_2}.00")
    expect(page).to have_content("Total: $#{grand_total}.00")
    expect(page).to have_button("Checkout")
  end

  it "visitor clicks on checkout with items in the cart and recieves message" do

    visit bike_shop_path

    within("#accessory-#{@accessory_1.id}") do
      click_button "Add to Cart"
    end

    2.times do
      within("#accessory-#{@accessory_2.id}") do
        click_button "Add to Cart"
      end
    end

    visit '/cart'

    click_button "Checkout"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Need to log in to checkout")
  end
  it "Registered user clicks on checkout with items in the cart and recieves message" do

    visit bike_shop_path

    within("#accessory-#{@accessory_1.id}") do
      click_button "Add to Cart"
    end

    2.times do
      within("#accessory-#{@accessory_2.id}") do
        click_button "Add to Cart"
      end
    end

    click_on 'Login'

    fill_in :username, with: @user.username
    fill_in :password, with: @user.password
    click_on "Log In"

    visit '/cart'

    click_button "Checkout"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully submitted your order totalling $55.00")
    expect(page).to_not have_content(@accessory_1.name)
    expect(page).to_not have_content("Price: $#{@accessory_1.price}.00")
    expect(page).to_not have_content(@accessory_2.name)
    expect(page).to_not have_content("Price: $#{@accessory_2.price}.00")
  end
  it 'registered users on checkout with no items in cart' do

    visit root_path

    click_on 'Login'

    fill_in :username, with: @user.username
    fill_in :password, with: @user.password
    click_on "Log In"

    visit '/cart'

    click_button "Checkout"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Add items to cart to checkout")
  end
end
