require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_accessories }
    it { should have_many(:accessories).through(:order_accessories) }
  end
end
