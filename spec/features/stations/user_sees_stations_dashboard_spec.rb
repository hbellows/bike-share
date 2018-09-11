require 'rails_helper'

describe "user visits stations dashboard" do
  before :each do
    @user = User.create(username: 'Joseph', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'see total count of stations' do
    Station.create!(name: 'Ferry Building', dock_count: 45, city: 'San Francisco', installation_date: Date.new(2017, 4, 12))
    Station.create!(name: 'Coit Tower', dock_count: 20, city: 'San Francisco', installation_date: Date.new(2017, 1, 17))

    visit stations_dashboard_path
save_and_open_page
    expect(page).to have_content("Total Station Count: #{Station.count}")
  end
end
