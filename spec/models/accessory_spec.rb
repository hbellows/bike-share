require 'rails_helper'

describe Accessory, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_presence_of :description }
    it { should validate_presence_of :image }
    it { should validate_uniqueness_of :name }
  end

  describe 'Relationships' do
    it { should have_many :order_accessories }
    it { should have_many(:orders).through(:order_accessories) }
  end
end
