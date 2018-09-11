require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_accessories }
    it { should have_many(:accessories).through(:order_accessories) }
  end

  describe 'Instance Methods' do
    it '#total' do
      user = create(:user)
      accessory1, accessory2 = create_list(:accessory, 2)

      order = user.orders.create(status: 'paid')
      order_item1 = order.order_accessories.create(accessory: accessory1, quantity: 2, unit_price: accessory1.price)
      order_item2 = order.order_accessories.create(accessory: accessory2, quantity: 3, unit_price: accessory1.price)

      expected_result = order_item1.subtotal + order_item2.subtotal

      expect(order.total).to eq(expected_result)
    end
  end
end
