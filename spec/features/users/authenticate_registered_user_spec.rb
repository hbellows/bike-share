require 'rails_helper'

describe 'registration and login' do
  describe 'login' do
    it 'existing user should be able to login' do
      username = 'bikeshareuser'
      user = User.create(email: 'xyz@gmale.com', username: username, password: 'test')

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: 'test'

      click_on "Log In"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{username}!")
      expect(page).to have_content("#{username}'s Dashboard")
      expect(page).to_not have_content('Login')
      expect(page).to have_content('Logout')
    end
  end
  describe 'logout' do
    it 'allows users to log out' do
      username = 'bikeshareuser'
      user = User.create(email: 'xyz@gmale.com', username: username, password: 'test')

      visit login_path
      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: 'test'

      click_on "Log In"

      expect(page).to_not have_content('Login')

      click_on 'Logout'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Login')
    end
  end
end
