require 'rails_helper'

describe 'As an admin' do
	describe 'When I visit /admin/accessories/edit/:id' do
		before(:each) do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			@accessory = create(:accessory)

			@accessory_name = 'Updated Accessory'
			@accessory_description = 'Updated Accessory description'
			@accessory_price = 66.6
		end
		it 'allows me to edit an accessory' do
			visit edit_admin_accessory_path(@accessory)

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Update Accessory'

			expect(current_path).to eq(accessory_path(@accessory))
			expect(page).to have_content("#{@accessory_name} updated!")
			expect(page).to have_content(@accessory_name)
			expect(page).to have_content(@accessory_description)
			expect(page).to have_content("Price: $#{@accessory_price}")
		end
		it 'requires name, description, and price fields' do
			visit edit_admin_accessory_path(@accessory)

			fill_in :accessory_name, with: ''
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: ''
			fill_in :accessory_price, with: @accessory_price
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: ''
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')
		end
		it 'requires that accessory name be unique' do
			create(:accessory, name: @accessory_name)

			visit edit_admin_accessory_path(@accessory)

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: @accessory_price
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')
		end
		it 'requires that price must be valid numerical value and greater than zero' do
			visit edit_admin_accessory_path(@accessory)

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: 'not a number'
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')

			fill_in :accessory_name, with: @accessory_name
			fill_in :accessory_description, with: @accessory_description
			fill_in :accessory_price, with: -1
			click_on 'Update Accessory'

			expect(current_path).to eq(edit_admin_accessory_path(@accessory))
			expect(page).to have_content('Accessory could not be updated.')
		end
	end
end