require 'rails_helper'

describe 'user visits accessory show page' do
  it "shows accessory and all attributes" do
    accessory_1 = Accessory.create(name: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00)

    visit accessory_path(accessory_1)

    expect(page).to have_content(accessory_1.name)
    expect(page).to have_content(accessory_1.description)
    expect(page).to have_content("Price: $900")
    expect(page).to have_button("Add to Cart")
  end
  it "shows a retired accessory correctly" do
    accessory_1 = Accessory.create(name: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00, retired?: true)

    visit accessory_path(accessory_1)

    expect(page).to have_content(accessory_1.name)
    expect(page).to have_content(accessory_1.description)
    expect(page).to have_content("Price: $900.00")
    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")
  end
end
