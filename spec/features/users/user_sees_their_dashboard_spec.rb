require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    before(:each) do
      @accessory1, @accessory2, @accessory3, @accessory4 = create_list(:accessory, 4)
      @user = create(:user)
      @order1 = @user.orders.create(status: 'paid', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)
      @order1.order_accessories.create(accessory: @accessory1, quantity: 2, unit_price: @accessory1.price)
      @order1.order_accessories.create(accessory: @accessory2, quantity: 1, unit_price: @accessory2.price)
      @order1.order_accessories.create(accessory: @accessory3, quantity: 1, unit_price: @accessory3.price)

      @order2 = @user.orders.create(status: 'ordered', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)
      @order2.order_accessories.create(accessory: @accessory1, quantity: 1, unit_price: @accessory1.price)
      @order2.order_accessories.create(accessory: @accessory2, quantity: 1, unit_price: @accessory2.price)
      @order2.order_accessories.create(accessory: @accessory3, quantity: 1, unit_price: @accessory3.price)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'displays a list of my orders' do
      visit dashboard_path

      expect(page).to have_content(@user.username)
      expect(page).to have_content("Order ##{@order1.id}")
      expect(page).to have_content("Order ##{@order2.id}")
    end
    it 'takes me to the order page when I click on an order' do
      visit dashboard_path

      click_link "Order ##{@order1.id}"

      expect(current_path).to eq(order_path(@order1))
      expect(page).to have_content("Order ##{@order1.id}")
      expect(page).to have_content("Order Status\n#{@order1.status.capitalize}")
      expect(page).to have_content("Order Submitted\n#{@order1.created_at.to_date}")

      expect(page).to have_content(@order1.accessories[0].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[0].id}") do
        expect(page).to have_content(@order1.order_accessories[0].quantity)
      end
      within("#order-accessory-subtotal-#{@order1.order_accessories[0].id}") do
        expect(page).to have_content(@order1.order_accessories[0].subtotal)
      end

      expect(page).to have_content(@order1.accessories[1].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[1].id}") do
        expect(page).to have_content(@order1.order_accessories[1].quantity)
      end
      within("#order-accessory-subtotal-#{@order1.order_accessories[1].id}") do
        expect(page).to have_content(@order1.order_accessories[1].subtotal)
      end

      expect(page).to have_content(@order1.accessories[2].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[2].id}") do
        expect(page).to have_content(@order1.order_accessories[2].quantity)
      end
      within("#order-accessory-subtotal-#{@order1.order_accessories[2].id}") do
        expect(page).to have_content(@order1.order_accessories[2].subtotal)
      end

      expect(page).to have_content("Order Total: $#{@order1.total}")
    end
    it 'will not show me another user\'s order' do
      user2 = create(:user)
      order3 = user2.orders.create(status: 'paid', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)

      visit order_path(order3)

      expect(current_path).to eq(root_path)
    end
  end
end
