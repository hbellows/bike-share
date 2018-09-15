require 'rails_helper'

describe OrderAccessory, type: :model do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :accessory }
  end

  describe 'Instance Methods' do
    before(:each) do
      @user = create(:user)
      @accessory = create(:accessory)
      @order = @user.orders.create(status: 'paid', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)
      @order_accessory = @order.order_accessories.create(accessory: @accessory, quantity: 2, unit_price: @accessory.price)
    end
    it "#accessory_name" do
      expect(@order_accessory.accessory_name).to eq(@accessory.name)
    end
    it "#subtotal" do
      expect(@order_accessory.subtotal).to eq(@order_accessory.quantity * @order_accessory.unit_price)
    end
  end
end
