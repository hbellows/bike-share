require 'rails_helper'

RSpec.describe Station, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end
  describe 'Relationshios' do
    it { should have_many(:start_stations).class_name('Trip').with_foreign_key('start_station_id').dependent(:destroy) }
    it { should have_many(:end_stations).class_name('Trip').with_foreign_key('end_station_id').dependent(:destroy) }
  end
  describe 'Instance Methods' do
    before(:each) do
      @station1, @station2 = create_list(:station, 2)
    end
    it '#number_rides_started' do
      create_list(:trip, 5, start_station: @station1, end_station: @station2)

      expect(@station1.number_rides_started).to eq(5)
    end
    it '#number_rides_ended' do
      create_list(:trip, 8, start_station: @station1, end_station: @station2)

      expect(@station1.number_rides_started).to eq(8)
    end
    it '#most_frequent_destination' do
      create_list(:trip, 5, start_station: @station1, end_station: @station2)
      create_list(:trip, 10, start_station: @station1, end_station: @station2)

      expect(@station1.most_frequent_destination).to eq(@station2.name)
    end
    it '#most_frequent_origination' do
      @station1 = create(:station)
      @station2 = create(:station)

      create_list(:trip, 5, start_station: @station1, end_station: @station2)
      create_list(:trip, 10, start_station: @station2, end_station: @station1)

      expect(@station1.most_frequent_origination).to eq(@station2.name)
    end
    it '#date_for_most_trips_started' do
      create_list(:trip, 8, start_date: '2015-09-12', start_station: @station1, end_station: @station2)
      create_list(:trip, 5, start_station: @station1, end_station: @station2)

      expect(@station1.date_for_most_trips_started).to eq(Date.parse('2015-09-12'))
    end
    it '#top_starting_user_zipcode' do
      create_list(:trip, 5, zip_code: 80401, start_station: @station1, end_station: @station2)
      create_list(:trip, 4, zip_code: 82451, start_station: @station1, end_station: @station2)

      expect(@station1.top_starting_user_zipcode).to eq(80401)
    end
    it '#top_starting_bike_id' do
      create_list(:trip, 10, bike_id: 202, start_station: @station1, end_station: @station2)
      create_list(:trip, 8, start_station: @station1, end_station: @station2)

      expect(@station1.top_starting_bike_id).to eq(202)
    end
  end
end
