require 'rails_helper'

describe 'Registered user visits conditions dashboard' do
  it 'sees the average number of rides for degree range' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      station_1, station_2 = create_list(:station, 2)
      create_list(:trip, 5, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-09 16:34:34', end_date: '2018-09-11 17:34:34')
      create_list(:trip, 10, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-10 16:34:34', end_date: '2018-09-11 17:34:34')
      create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-12 17:34:34')
      create_list(:trip, 16, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-13 17:34:34')
      create_list(:trip, 2, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')
      create_list(:trip, 10, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-16 16:34:34', end_date: '2018-09-13 17:34:34')
      create_list(:trip, 1, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-17 16:34:34', end_date: '2018-09-13 17:34:34')
      create(:condition, max_temperature: 40, precipitation: 0.5, mean_wind_speed: 0, mean_visibility: 0, date: '2018-09-09 16:34:34')
      create(:condition, max_temperature: 49.9, precipitation: 0.7, mean_wind_speed: 4, mean_visibility: 4, date: '2018-09-10 16:34:34')
      create(:condition, max_temperature: 50, precipitation: 0, mean_wind_speed: 7, mean_visibility: 13, date: '2018-09-11 16:34:34')
      create(:condition, max_temperature: 59.9, precipitation: 1, mean_wind_speed: 22, mean_visibility: 11, date: '2018-09-12 16:34:34')
      create(:condition, max_temperature: 85, precipitation: 1.5, mean_wind_speed: 3, mean_visibility: 15, date: '2018-09-13 16:34:34')
      create(:condition, max_temperature: 80, precipitation: 3, mean_wind_speed: 15, mean_visibility: 20, date: '2018-09-16 16:34:34')
      create(:condition, max_temperature: 99, precipitation: 2, mean_wind_speed: 10, mean_visibility: 1, date: '2018-09-17 16:34:34')


    visit conditions_dashboard_path

    expect(page).to have_content("Conditions Dashboard")
    expect(page).to have_content("#{Condition.avg_rides_breakdown(70,79.9,'max_temperature')} rides")
    expect(page).to have_content("#{Condition.max_rides_breakdown(0.5,1,'precipitation')} rides")
    expect(page).to have_content("#{Condition.min_rides_breakdown(0,4,'mean_wind_speed')} rides")
    expect(page).to have_content("#{Condition.max_rides_breakdown(8,12,'mean_visibility')} rides")
  end
end
