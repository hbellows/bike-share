require 'rails_helper'

describe Cart do
  subject {Cart.new({1 => 2, 2 => 3})}

  describe '#add_accessory' do
    it 'adds accessories to its contents' do
      subject.add_accessory(1)
      subject.add_accessory(2)
      expect(subject.contents).to eq({1 => 3, 2 => 4})
    end
  end
  describe '#total_count' do
    it 'displays total count of accessories in cart' do
      expect(subject.total_count).to eq(5)
    end
  end
end
