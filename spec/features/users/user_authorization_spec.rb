require 'rails_helper'

feature 'User authorization' do
  scenario 'As an unregistered user' do
    it 'should redirect to /login when user tries to check out' do
      user = create(:user)
      visit cart_path #tbd
      click_on 'Check Out'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("You must be logged in to see this page.")
    end
    it 'does not allow a user to visit another users page' do
      user_1 = create(:user)
      visit root_path
      click_on('Login')
      fill_in :user_username, with: user_1.username
      fill_in :user_password, with: user_1.password
      click_on('Log in')
      order_1 = create(:order, user: user_1)


      user_2 = create(:user)
      order_2 = create(:order, user: user_2)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user1.name}")
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")

      visit "/orders/#{user_2.orders.last.id}"

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
    it 'do not allow user to visit admin pages' do
      user = build(:user) #build vs create

      visit root_path
      click_on("Login")

      expect(page).to have_content("Create Account")

      click_on("Create")

      fill_in :user_username, with: user.email
      fill_in :user_password, with: user.password
      click_on("Create")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user.username}")
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")

      visit '/admin/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
