require 'rails_helper'

describe 'registration and login' do
  describe 'registration' do
    username = 'bikeshareuser'

    visit root_path

    click_on 'Login'

    expect(current_path).to eq(login_path)

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in :username, with: username
    fill_in :password, with: 'test'
    fill_in :password_confirmation, with: 'test'

    click_on "Create User"

    expect(page).to have_content("Logged in as #{username}!")
    expect(page).to have_content("#{username}'s Dashboard")
    expect(page).to_not have_content('Login')
    expect(page).to have_content('Logout')
  end
end
