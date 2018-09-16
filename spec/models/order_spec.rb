require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_accessories }
    it { should have_many(:accessories).through(:order_accessories) }
  end
  describe 'Validations' do
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city           }
    it { should validate_presence_of :state          }
    it { should validate_presence_of :zip_code       }
  end
  describe 'Scopes' do
    it '#filter_by_status' do
      user = create(:user)
      order1 = create(:order, status: 'paid', user_id: user.id)
      order2 = create(:order, status: 'cancelled', user_id: user.id)
      order3 = create(:order, status: 'completed', user_id: user.id)
      order4 = create(:order, status: 'completed', user_id: user.id)

      expect(Order.filter_by_status('paid').first).to eq(order1)
      expect(Order.filter_by_status('completed').to_a).to eq([order3, order4])
    end
  end
  describe 'Class Methods' do
    it '.status_count(status)' do
      user = create(:user)
      order1 = create(:order, status: 'paid', user_id: user.id)
      order2 = create(:order, status: 'cancelled', user_id: user.id)
      order3 = create(:order, status: 'completed', user_id: user.id)
      order4 = create(:order, status: 'completed', user_id: user.id)

      expected_result = {
        'paid'      => 1,
        'completed' => 2,
        'cancelled' => 1
      }

      expect(Order.status_count).to eq(expected_result)
    end
  end
  describe 'Instance Methods' do
    it '#total' do
      user = create(:user)
      accessory1, accessory2 = create_list(:accessory, 2)

      order = user.orders.create(status: 'paid', street_address: '222 Ave', city: 'Denver', state: 'CO', zip_code: 80401)
      order_item1 = order.order_accessories.create(accessory: accessory1, quantity: 2, unit_price: accessory1.price)
      order_item2 = order.order_accessories.create(accessory: accessory2, quantity: 3, unit_price: accessory1.price)

      expected_result = (order_item1.subtotal + order_item2.subtotal).round(2)

      expect(order.total).to eq(expected_result)
    end
  end
end
