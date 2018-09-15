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
    describe "high_temp_breakdown method" do
      it "should return average/max/min rides at range of high temperature" do
        station_1, station_2 = create_list(:station, 2)
        create(:condition, max_temperature: 72, date: '2018-09-11 16:34:34')
        create(:condition, max_temperature: 72, date: '2018-09-12 16:34:34')
        create_list(:trip, 4, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-11 16:34:34', end_date: '2018-09-11 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-12 16:34:34', end_date: '2018-09-12 17:34:34')
        create_list(:trip, 8, start_station_id: station_1.id, end_station_id: station_2.id, start_date: '2018-09-13 16:34:34', end_date: '2018-09-13 17:34:34')

        expect(Condition.max_rides_high_temp_breakdown(70,79.9)).to eq(8)
        expect(Condition.min_rides_high_temp_breakdown(70,79.9)).to eq(4)
        expect(Condition.avg_rides_high_temp_breakdown(70,79.9)).to eq(6)
      end
    end
  end
end
