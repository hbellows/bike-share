require 'rails_helper'

describe 'Registered user visits conditions dashboard' do
  xit 'sees the average number of rides for degree range' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    station_1, station_2 = create_list(:station, 2)
    condition_1, condition_2, condition_3, condition_4 = create_list(:condition, 4, date: '2018-09-11 16:34:34')
    create_list(:condition, 4, date: '2018-09-12 16:34:34')
    create_list(:condition, 4, date: '2018-09-13 16:34:34')
    create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
    create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-11 17:34:34')
    create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-11 17:34:34')

    visit conditions_dashboard_path

    expect(page).to have_content()

  end
end
