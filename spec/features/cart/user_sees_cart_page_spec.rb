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

  it "clicks on checkout and button and recieves message" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

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

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully submitted your order totalling $55.00")

    visit '/cart'

    expect(page).to_not have_content(@accessory_1.name)
    expect(page).to_not have_content("Price: $#{@accessory_1.price}.00")
    expect(page).to_not have_content(@accessory_2.name)
    expect(page).to_not have_content("Price: $#{@accessory_2.price}.00")
  end
end
