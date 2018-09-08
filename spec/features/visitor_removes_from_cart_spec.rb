require 'rails_helper'

feature 'visitor removes accessories from cart' do
  accessory_1 = Accessory.create(title: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00)
  accessory_2 = Accessory.create(title: "Kid's bell", description: 'In case they didnt see you already, ring this cute bell', price: 11.00)

  visit bike_shop_path

  within("#accessory-#{accessory_1.id}") do
    click_button 'Add to cart'
  end

  3.times do
    within("#accessory-#{accessory_2.id}") do
      click_button 'Add to cart'
    end
  end

  scenario 'not logged in with accessories in cart' do

    visit '/cart'

    within("#accessory-#{accessory_2.id}") do
      click_link 'Remove'
    end

    expect(flash[:alert]).to eq "Successfully removed #{accessory_2.title} from your cart."
    expect(page).to have_content(accessory_1.title)
    expect(page).to have_content(accessory_1.price)
    expect(page).to_not have_content(accessory_2.price)

    click_on accessory_2.title

    expect(current_path).to eq(accessory_path(accessory_2))
  end
  scenario "visitor decreases one of the same accessory" do

    visit '/cart'

    expect(page).to have_content(accessory_1.title)
    expect(page).to have_content(accessory_1.price)
    expect(page).to have_content(accessory_2.title)
    expect(page).to have_content(accessory_2.price)
    expect(page).to have_content("quantity: 1")
    expect(page).to have_content("quantity: 3")
    expect(page).to have_content("Total: 933.00")

    within("#accessory-#{accessory_2.id}") do
      click_button 'decrease quantity'
    end

    expect(page).to have_content("quantity: 1")
    expect(page).to have_content("quantity: 2")
    expect(page).to have_content("Total: 922.00")
  end
end
