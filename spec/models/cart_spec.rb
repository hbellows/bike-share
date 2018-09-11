require 'rails_helper'

describe Cart do
  before(:each) do
    @accessory_1 = create(:accessory, price: 10)
    @accessory_2 = create(:accessory, price: 11)
  end
  subject {Cart.new({@accessory_1.id => 2, @accessory_2.id => 3})}

  describe '#add_accessory' do
    it 'adds accessories to its contents' do
      subject.add_accessory(@accessory_1.id)
      subject.add_accessory(@accessory_2.id)
      expect(subject.contents).to eq({@accessory_1.id => 3, @accessory_2.id => 4})
    end
  end
  describe '#total_count' do
    it 'displays total count of accessories in cart' do
      expect(subject.total_count).to eq(5)
    end
  end
  describe '#total_price' do
    it 'displays total price of accessories in cart' do
      expect(subject.total_price).to eq(53)
    end
  end
  describe '#accessories_and_quantity' do
    it 'combines accessory object to its quantity' do
      subject.add_accessory(@accessory_1.id)
      subject.add_accessory(@accessory_2.id)

      expect(subject.accessories_and_quantity).to eq({@accessory_1 => 3, @accessory_2 => 4})
    end
  end
end
