require 'rails_helper'

describe 'registration and login' do
  describe 'registration' do
    username = 'bikeshareuser'
    user = User.create(username: username, password: 'test')

    visit root_path

    click_on 'Login'

    expect(current_path).to eq(login_path)

    fill_in :username, with: username
    fill_in :password, with: 'test'

    click_on "Log In"

    expect(page).to have_content("Logged in as #{username}!")
    expect(page).to have_content("#{username}'s Dashboard")
    expect(page).to_not have_content('Login')
    expect(page).to have_content('Logout')
  end
end
