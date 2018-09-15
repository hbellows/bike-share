require 'rails_helper'

describe 'As an admin' do
  describe 'When I visist the admin dashboard' do
    before(:each) do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      user1, user2 = create_list(:user, 2)

      @order1 = create(:order, user_id: user1.id, status: 'ordered')
      @order2 = create(:order, user_id: user1.id, status: 'paid')
      @order3 = create(:order, user_id: user2.id, status: 'completed')
      @order4 = create(:order, user_id: user2.id, status: 'completed')
    end
    it 'shows me a list of all orders' do
      visit admin_dashboard_path

      within("#order-#{@order1.id}") do
        expect(page).to have_content("Order ##{@order1.id}")
        expect(page).to have_content("User: #{@order1.user.username}")
        expect(page).to have_content("Status: #{@order1.status.capitalize}")
      end
      within("#order-#{@order2.id}") do
        expect(page).to have_content("Order ##{@order2.id}")
        expect(page).to have_content("User: #{@order2.user.username}")
        expect(page).to have_content("Status: #{@order2.status.capitalize}")
      end
      within("#order-#{@order3.id}") do
        expect(page).to have_content("Order ##{@order3.id}")
        expect(page).to have_content("User: #{@order3.user.username}")
        expect(page).to have_content("Status: #{@order3.status.capitalize}")
      end
      within("#order-#{@order4.id}") do
        expect(page).to have_content("Order ##{@order4.id}")
        expect(page).to have_content("User: #{@order4.user.username}")
        expect(page).to have_content("Status: #{@order4.status.capitalize}")
      end
    end
    it 'shows me the total number of orders for each status' do
      visit admin_dashboard_path

      expect(page).to have_content("Ordered: 1")
      expect(page).to have_content("Paid: 1")
      expect(page).to have_content("Completed: 2")
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
      expect(page).to have_content("Status: #{@order1.status.capitalize}")
      expect(page).to_not have_content("Status: Completed")
      expect(page).to_not have_content("Status: Cancelled")
      expect(page).to_not have_content("Status: Paid")

      select 'Completed', from: :filter_by_status
      click_on 'Filter'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Status: #{@order3.status.capitalize}")
      expect(page).to_not have_content("Status: Paid")
      expect(page).to_not have_content("Status: Cancelled")
    end
  end
end


# I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed"),
# I have links to transition between statuses
#
# I can click on "cancel" on individual orders which are "paid" or "ordered"
# I can click on "mark as paid" on orders that are "ordered"
# I can click on "mark as completed" on orders that are "paid"
