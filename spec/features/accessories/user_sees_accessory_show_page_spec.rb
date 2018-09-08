require 'rails_helper'

describe 'user visits accessory show page' do
  it "shows accessory and all attributes" do
    accessory_1 = Accessory.create(title: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00)

    visit accessory_show_path(accessory_1)

    expect(page).to have_content(accessory_1.title)
    expect(page).to have_content(accessory_1.description)
    expect(page).to have_content("Price: #{accessory_1.price}")
    expect(page).to have_button("Add to Cart")
  end
  it "shows a retired accessory correctly" do
    accessory_1 = Accessory.create(title: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00, retired?: true)

    visit accessory_show_path(accessory_1)

    expect(page).to have_content(accessory_1.title)
    expect(page).to have_content(accessory_1.description)
    expect(page).to have_content("Price: #{accessory_1.price}")
    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")

  end
end
