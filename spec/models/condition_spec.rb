require 'rails_helper'

RSpec.describe Condition, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :max_temperature }
    it { should validate_presence_of :mean_temperature }
    it { should validate_presence_of :min_temperature }
    it { should validate_presence_of :mean_humidity }
    it { should validate_presence_of :mean_visibility }
    it { should validate_presence_of :mean_wind_speed }
    it { should validate_presence_of :precipitation }
  end
  describe "class methods" do
    describe "high_temp_breakdown methods" do
      it "should return average/max/min rides at range of high temperature" do
        station_1, station_2 = create_list(:station, 2)
        create(:condition, max_temperature: 72, date: '2018-09-11 16:34:34')
        create(:condition, max_temperature: 72, date: '2018-09-12 16:34:34')
        create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-12 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')

        expect(Condition.max_rides_breakdown(40,49.9,'max_temperature')).to eq(0)
        expect(Condition.max_rides_breakdown(70,79.9,'max_temperature')).to eq(8)
        expect(Condition.min_rides_breakdown(70,79.9,'max_temperature')).to eq(4)
        expect(Condition.avg_rides_breakdown(70,79.9,'max_temperature')).to eq(6)
      end
    end
    describe "precipitation_breakdown methods" do
      it "should return average/max/min rides at range of precipitation" do
        station_1, station_2 = create_list(:station, 2)
        create(:condition, precipitation: 0.5, date: '2018-09-11 16:34:34')
        create(:condition, precipitation: 0.7, date: '2018-09-12 16:34:34')
        create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-12 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')

        expect(Condition.max_rides_breakdown(0.5,1,'precipitation')).to eq(8)
        expect(Condition.min_rides_breakdown(0.5,1,'precipitation')).to eq(4)
        expect(Condition.avg_rides_breakdown(0.5,1,'precipitation')).to eq(6)
      end
    end
    describe "precipitation_breakdown methods" do
      it "should return average/max/min rides at range of mean_wind_speed" do
        station_1, station_2 = create_list(:station, 2)
        create(:condition, mean_wind_speed: 0, date: '2018-09-11 16:34:34')
        create(:condition, mean_wind_speed: 4, date: '2018-09-12 16:34:34')
        create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-12 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')

        expect(Condition.max_rides_breakdown(0,4,'mean_wind_speed')).to eq(8)
        expect(Condition.min_rides_breakdown(0,4,'mean_wind_speed')).to eq(4)
        expect(Condition.avg_rides_breakdown(0,4,'mean_wind_speed')).to eq(6)
      end
    end
    describe "precipitation_breakdown methods" do
      it "should return average/max/min rides at range of mean_visibility" do
        station_1, station_2 = create_list(:station, 2)
        create(:condition, mean_visibility: 0, date: '2018-09-11 16:34:34')
        create(:condition, mean_visibility: 4, date: '2018-09-12 16:34:34')
        create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-12 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')

        expect(Condition.max_rides_breakdown(0,4,'mean_visibility')).to eq(8)
        expect(Condition.min_rides_breakdown(0,4,'mean_visibility')).to eq(4)
        expect(Condition.avg_rides_breakdown(0,4,'mean_visibility')).to eq(6)
      end
    end
    describe "breakdown methods" do
      it "should return a hash of attribute ranges and their respective values" do
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

        expect(Condition.max_temp_breakdown).to eq(
          {"max_rides"=>{"40s"=>10, "50s"=>16, "60s"=>0, "70s"=>0, "80s"=>10, "90s"=>1},
          "avg_rides"=>{"40s"=>7.5, "50s"=>12.0, "60s"=>0, "70s"=>0, "80s"=>6.0, "90s"=>1.0},
          "min_rides"=>{"40s"=>5, "50s"=>8, "60s"=>0, "70s"=>0, "80s"=>2, "90s"=>1}})
        expect(Condition.precip_breakdown).to eq(
          {"max_rides"=>{"half"=>8, "one"=>10, "one_half"=>16, "two"=>2, "two_half"=>1, "three"=>0, "three_half"=>10},
          "avg_rides"=>{"half"=>8.0, "one"=>7.5, "one_half"=>16.0, "two"=>2.0, "two_half"=>1.0, "three"=>0, "three_half"=>10.0},
          "min_rides"=>{"half"=>8, "one"=>5, "one_half"=>16, "two"=>2, "two_half"=>1, "three"=>0, "three_half"=>10}})
        expect(Condition.wind_breakdown).to eq(
          {"max_rides"=>{"four"=>5, "eight"=>10, "twelve"=>1, "sixteen"=>10, "twenty"=>0, "twenty_four"=>16},
          "avg_rides"=>{"four"=>3.5, "eight"=>9.0, "twelve"=>1.0, "sixteen"=>10.0, "twenty"=>0, "twenty_four"=>16.0},
          "min_rides"=>{"four"=>2, "eight"=>8, "twelve"=>1, "sixteen"=>10, "twenty"=>0, "twenty_four"=>16}})
        expect(Condition.visibility_breakdown).to eq(
          {"max_rides"=>{"four"=>5, "eight"=>10, "twelve"=>16, "sixteen"=>8, "twenty"=>0, "twenty_four"=>10},
          "avg_rides"=>{"four"=>3.0, "eight"=>10.0, "twelve"=>16.0, "sixteen"=>5.0, "twenty"=>0, "twenty_four"=>10.0},
          "min_rides"=>{"four"=>1, "eight"=>10, "twelve"=>16, "sixteen"=>2, "twenty"=>0, "twenty_four"=>10}})
      end
    end
  end
end
