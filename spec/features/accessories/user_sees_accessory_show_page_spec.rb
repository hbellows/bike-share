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
    expect(page).to_not have_button("Retire")
    expect(page).to_not have_button("Reactivate")
  end
  it "shows a retired accessory correctly" do
    @accessory.update(retired?: true)
    visit accessory_path(@accessory)

    expect(page).to have_content(@accessory.name)
    expect(page).to have_content(@accessory.description)
    expect(page).to have_content("$#{@accessory.price}")
    expect(page).to have_content("Accessory Not Available")
    expect(page).to_not have_button("Add to Cart")
    expect(page).to_not have_button("Retire")
    expect(page).to_not have_button("Reactivate")
  end
end
describe 'admin visits accessory show page' do
  before(:each) do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    @accessory = create(:accessory)
  end
  it "shows accessory and all attributes" do
    visit accessory_path(@accessory)

    expect(page).to have_content(@accessory.name)
    expect(page).to have_content(@accessory.description)
    expect(page).to have_content("$#{@accessory.price}")
    expect(page).to have_button("Retire")
    expect(page).to_not have_button("Reactivate")
    expect(page).to have_button("Add to Cart")
  end
  it "shows a retired accessory correctly" do
    @accessory.update(retired?: true)
    visit accessory_path(@accessory)

    expect(page).to have_content(@accessory.name)
    expect(page).to have_content(@accessory.description)
    expect(page).to have_content("$#{@accessory.price}")
    expect(page).to have_button("Reactivate")
    expect(page).to_not have_button("Retire")
    expect(page).to_not have_button("Add to Cart")
  end
end
