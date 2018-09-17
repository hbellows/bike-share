require 'rails_helper'

describe 'As an admin' do
	it 'allows me to visit a user show page' do
		admin = create(:admin)
		user  = create(:user)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

		visit user_path(user)

		expect(current_path).to eq(user_path(user))
		expect(page).to have_content(user.username)
	end
end