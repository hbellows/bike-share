require 'rails_helper'

describe OrderAccessory, type: :model do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :accessory }
  end

  describe 'Instance Methods' do
    it "#accessory_name" do
      user = create(:user)
      accessory = create(:accessory)
      order = user.orders.create(status: 'paid')
      order_accessory = order.order_accessories.create(accessory: accessory, quantity: 2, unit_price: accessory.price)

      expect(order_accessory.accessory_name).to eq(accessory.name)
    end
    it "#subtotal" do
      user = create(:user)
      accessory = create(:accessory)
      order = user.orders.create(status: 'paid')
      order_accessory = order.order_accessories.create(accessory: accessory, quantity: 2, unit_price: accessory.price)

      expect(order_accessory.subtotal).to eq(order_accessory.quantity * order_accessory.unit_price)
    end
  end
end
