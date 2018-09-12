require 'rails_helper'

RSpec.describe Station, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end
  describe 'Instance Methods' do
    it '#number_rides_started' do
      station = create(:station)
      create_list(:trip, 5, start_station_id: station.id)

      expect(station.number_rides_started).to eq(5)
    end
    it '#number_rides_ended' do
      station = create(:station)
      create_list(:trip, 8, start_station_id: station.id)

      expect(station.number_rides_started).to eq(8)
    end
    it '#most_frequent_destination' do
      station = create(:station)
      terminal_station = create(:station)

      create_list(:trip, 5, start_station_id: station.id, end_station_id: terminal_station.id)
      create_list(:trip, 10, start_station_id: station.id)

      expect(station.most_frequent_destination).to eq(terminal_station.name)
    end
    it '#most_frequent_origination' do
      station = create(:station)
      origin_station = create(:station)

      create_list(:trip, 5, start_station_id: station.id, end_station_id: origin_station.id)
      create_list(:trip, 10, start_station_id: origin_station.id, end_station_id: station.id)

      expect(station.most_frequent_origination).to eq(origin_station.name)
    end
    it '#date_for_most_trips_started' do
      station = create(:station)

      create_list(:trip, 8, start_date: '2015-09-12', start_station_id: station.id)
      create_list(:trip, 5, start_station_id: station.id)

      expect(station.date_for_most_trips_started).to eq(Date.parse('2015-09-12'))
    end
    it '#top_starting_user_zipcode' do
      station = create(:station)

      create_list(:trip, 5, zip_code: 80401, start_station_id: station.id)
      create_list(:trip, 4, zip_code: 82451, start_station_id: station.id)

      expect(station.top_starting_user_zipcode).to eq(80401)
    end
    it '#top_starting_bike_id' do
      station = create(:station)

      create_list(:trip, 10, bike_id: 202, start_station_id: station.id)
      create_list(:trip, 8, start_station_id: station.id)

      expect(station.top_starting_bike_id).to eq(202)
    end
  end
end
