require 'rails_helper'

describe 'user visits accessory show page' do
  before(:each) do
    @accessory = create(:accessory)
  end
  it "shows accessory and all attributes" do
    visit accessory_path(@accessory)

    expect(page).to have_content(@accessory.name)
    expect(page).to have_content(@accessory.description)
    expect(page).to have_content("$#{@accessory.price}")
    expect(page).to have_button("Add to Cart")
  end
  it "shows a retired accessory correctly" do
    @accessory.update(retired?: true)
    visit accessory_path(@accessory)

    expect(page).to have_content(@accessory.name)
    expect(page).to have_content(@accessory.description)
    expect(page).to have_content("$#{@accessory.price}")
    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")
  end
end
