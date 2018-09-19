require 'rails_helper'

describe 'As an admin' do
  describe 'When I visist the admin dashboard' do
    before(:each) do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      user1, user2 = create_list(:user, 2)
      accessory = create(:accessory)

      @order1 = create(:order, user_id: user1.id, status: 'ordered')
      @order1.order_accessories.create(accessory_id: accessory.id, quantity: 2, unit_price: accessory.price)
      @order2 = create(:order, user_id: user1.id, status: 'paid')
      @order3 = create(:order, user_id: user2.id, status: 'completed')
      @order4 = create(:order, user_id: user2.id, status: 'completed')
    end
    it 'shows me a list of all orders' do
      visit admin_dashboard_path

      within("#order-#{@order1.id}") do
        expect(page).to have_content("Order ##{@order1.id}")
        expect(page).to have_content(@order1.user.username)
        expect(page).to have_content(@order1.status.capitalize)
      end
      within("#order-#{@order2.id}") do
        expect(page).to have_content("Order ##{@order2.id}")
        expect(page).to have_content(@order2.user.username)
        expect(page).to have_content(@order2.status.capitalize)
      end
      within("#order-#{@order3.id}") do
        expect(page).to have_content("Order ##{@order3.id}")
        expect(page).to have_content(@order3.user.username)
        expect(page).to have_content(@order3.status.capitalize)
      end
      within("#order-#{@order4.id}") do
        expect(page).to have_content("Order ##{@order4.id}")
        expect(page).to have_content(@order4.user.username)
        expect(page).to have_content(@order4.status.capitalize)
      end
    end
    it 'shows me the total number of orders for each status' do
      visit admin_dashboard_path

      expect(page).to have_content("Ordered\n1")
      expect(page).to have_content("Paid\n1")
      expect(page).to have_content("Completed\n2")
    end
    it 'links to each order show page' do
      visit admin_dashboard_path

      expect(page).to have_link("Order ##{@order1.id}", href: order_path(@order1))
    end
    it 'allows me to filter orders by status' do
      visit admin_dashboard_path

      select 'Ordered', from: :filter_by_status
      click_on 'Filter'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Status\n#{@order1.status.capitalize}")
      expect(page).to_not have_content("Status: Completed")
      expect(page).to_not have_content("Status: Cancelled")
      expect(page).to_not have_content("Status: Paid")

      select 'Completed', from: :filter_by_status
      click_on 'Filter'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Status\n#{@order3.status.capitalize}")
      expect(page).to_not have_content("Status\nPaid")
      expect(page).to_not have_content("Status\nCancelled")
    end
    it 'allows me to cancel orders that are paid or ordered' do
      visit admin_dashboard_path

      within("#order-#{@order1.id}") do
        click_link 'Cancel'
      end
      expect(current_path).to eq(admin_dashboard_path)
      within("#order-#{@order1.id}") do
        expect(page).to have_content("Cancelled")
      end

      within("#order-#{@order2.id}") do
        click_link 'Cancel'
      end
      expect(current_path).to eq(admin_dashboard_path)
      within("#order-#{@order2.id}") do
        expect(page).to have_content("Cancelled")
      end
    end
    it 'allows me to mark as paid orders which are ordered' do
      visit admin_dashboard_path

      within("#order-#{@order1.id}") do
        click_link 'Mark as Paid'
      end
      expect(current_path).to eq(admin_dashboard_path)
      within("#order-#{@order1.id}") do
        expect(page).to have_content("Paid")
      end
    end
    it 'allows me to mark as completed orders which are paid' do
      visit admin_dashboard_path

      within("#order-#{@order2.id}") do
        click_link 'Mark as Completed'
      end
      expect(current_path).to eq(admin_dashboard_path)
      within("#order-#{@order2.id}") do
        expect(page).to have_content("Completed")
      end
    end
    it 'allows me to click an order and see that order\'s details' do
      visit admin_dashboard_path

      click_link "Order ##{@order1.id}"

      expect(page).to have_content("Order ##{@order1.id}")
      expect(page).to have_content("Order Status\n#{@order1.status.capitalize}")
      expect(page).to have_content("Order Submitted\n#{@order1.created_at.to_date}")
      expect(page).to have_content("Ordered by\n#{@order1.user.full_name}")
      expect(page).to have_content("Shipping Address:\n#{@order1.street_address}")
      expect(page).to have_content("#{@order1.city}, #{@order1.state} #{@order1.zip_code}")
      expect(page).to have_link(@order1.accessories.first.name, href: accessory_path(@order1.accessories.first))
    end
  end
end
