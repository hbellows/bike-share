require 'rails_helper'

describe 'user visits accessory show page' do
  it "shows accessory and all attributes" do
    accessory = create(:accessory)

    visit accessory_path(accessory)

    expect(page).to have_content(accessory.name)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content("Price: $#{accessory.price}")
    expect(page).to have_button("Add to Cart")
  end
  it "shows a retired accessory correctly" do
    accessory = create(:accessory, retired?: true)

    visit accessory_path(accessory)

    expect(page).to have_content(accessory.name)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content("Price: $#{accessory.price}")
    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")
  end
end
