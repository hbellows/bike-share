require 'rails_helper'

describe 'As an admin' do
	describe 'When I visit /admin/accessories/new' do
		it 'allows me to create a new accessory' do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			visit new_admin_accessory_path

			accessory_name = 'New Accessory'
			accessory_description = 'Accessory description'
			accessory_price = 12.05

			fill_in :accessory_name, with: accessory_name
			fill_in :accessory_description, with: accessory_description
			fill_in :accessory_price, with: accessory_price
			click_on 'Create Accessory'

			expect(current_path).to eq(accessory_path(Accessory.last))
			expect(page).to have_content(accessory_name)
			expect(page).to have_content(accessory.description)
			expect(page).to have_content("Price: $#{accessory_price}")
		end
	end
end

# As an admin user,
# When I visit admin bikeshop new
# I can create an accessory,
# An accessory must have a title, description and price,
# The title and description cannot be empty,
# The title must be unique for all accessories in the system,
# The price must be a valid decimal numeric value and greater than zero,
# The photo is optional. If not present, a stand-in photo is used. (PAPERCLIP)