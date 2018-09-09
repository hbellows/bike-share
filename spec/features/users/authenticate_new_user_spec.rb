require 'rails_helper'

describe 'registration and login' do
  describe 'registration' do
    it 'new user should be able to register' do
      username = 'bikeshareuser'

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      click_on "Create Account"

      expect(current_path).to eq(new_user_path)

      fill_in :user_email, with: "xyz@gmale.com"
      fill_in :user_username, with: username
      fill_in :user_password, with: 'test'
      fill_in :user_password_confirmation, with: 'test'

      click_on "Create User"

      expect(page).to have_content("Logged in as #{username}!")
      expect(page).to have_content("#{username}'s Dashboard")
      expect(page).to_not have_content('Login')
      expect(page).to have_content('Logout')
    end
  end
end
