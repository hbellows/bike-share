require 'rails_helper'

describe 'As an admin' do
	describe 'When I visit my own show page' do
		it 'shows my my own show page' do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			visit dashboard_path

			expect(page).to have_content ("#{admin.username}'s Dashboard")
		end
	end
end