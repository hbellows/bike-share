require 'rails_helper'

describe 'As an admin' do
	describe 'When I visit /admin/accessories/new' do
		before(:each) do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			@accessory_name = 'New Accessory'
			@accessory_description = 'Accessory description'
			@accessory_price = 12.05
		end
		it 'allows me to create a new accessory' do
			visit new_admin_accessory_path

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Create Accessory'

			expect(current_path).to eq(accessory_path(Accessory.last))
			expect(page).to have_content("#{@accessory_name} created!")
			expect(page).to have_content(@accessory_name)
			expect(page).to have_content(@accessory_description)
			expect(page).to have_content("$#{@accessory_price}")
		end
		it 'requires name, description, and price fields' do
			visit new_admin_accessory_path

			fill_in :accessory_name, with: ''
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: ''
			fill_in :accessory_price, with: @accessory_price
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: ''
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')
		end
		it 'requires that accessory name be unique' do
			create(:accessory, name: @accessory_name)

			visit new_admin_accessory_path

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')
		end
		it 'requires that price must be valid numerical value and greater than zero' do
			visit new_admin_accessory_path

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: 'not a number'
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: -1
			click_on 'Create Accessory'

			expect(current_path).to eq(new_admin_accessory_path)
			expect(page).to have_content('Accessory could not be created.')
		end
	end
end
