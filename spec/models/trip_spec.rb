require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :start_station_id }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :end_station_id }
    it { should validate_presence_of :bike_id }
    it { should validate_presence_of :subscription_type }
    it { should validate_presence_of :zip_code }
  end
  describe 'Relationships' do
    it { should belong_to(:start_station).class_name('Station').with_foreign_key('start_station_id') }
    it { should belong_to(:end_station).class_name('Station').with_foreign_key('end_station_id') }
  end
end