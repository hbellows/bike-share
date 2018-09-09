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
end
