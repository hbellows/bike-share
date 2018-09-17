require 'rails_helper'

describe "user visits stations dashboard" do
  before :each do
    @user = User.create(username: 'Joseph', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @station_1, @station_2 = create_list(:station, 2)
  end
  it 'see total count of stations' do
    visit stations_dashboard_path

    expect(page).to have_content("#{Station.count}")
  end
  it 'see average_bikes_per_station' do
    visit stations_dashboard_path

    expect(page).to have_content("#{Station.average_bikes_per_station}")
  end
  it 'see most bikes per stations' do
    visit stations_dashboard_path

    expect(page).to have_content(@station_1.name)
  end
  it 'see station with most bikes' do
    visit stations_dashboard_path

    expect(page).to have_content("#{@station_1.name}")
  end
  it 'see least bikes per stations' do
    visit stations_dashboard_path

    expect(page).to have_content("#{@station_1.dock_count}")
  end

  it 'see station with least bikes' do
    visit stations_dashboard_path

    expect(page).to have_content("#{@station_1.name}")
  end
  it 'can see most recently installed station' do
    visit stations_dashboard_path

    expect(page).to have_content("#{@station_1.name}")
  end
  it 'can see oldest station' do
    visit stations_dashboard_path

    expect(page).to have_content("#{@station_2.name}")
  end
end
