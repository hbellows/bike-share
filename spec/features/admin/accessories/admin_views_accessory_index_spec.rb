# As an admin user,
# When I visit "/admin/dashboard",
# I see a link for viewing all accessories,
# When I click that link,
# My current path should be "/admin/bike-shop",
# I see a table with all accessories (active and inactive)
#
# Each accessory should have:
#
# A thumbnail of the image
# Description
# Status
# Ability to Edit accessory
# Ability to Retire/Reactivate accessory

require 'rails_helper'

describe 'As an admin' do
	describe 'When I visist /admin/bike-shop' do
		before(:each) do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
			@accessory1 = create(:accessory)
			@accessory2 = create(:accessory, retired?: true)
		end
		it 'shows me a list of all accessories' do
			visit admin_bike_shop_path

			within("#accessory-#{@accessory1.id}") do
				expect(page).to have_content(@accessory1.name)
				expect(page).to have_content(@accessory1.description)
				expect(page).to have_content(@accessory1.price)
				expect(page).to have_content('Active')
				expect(page).to have_content('Edit')
				expect(page).to have_content('Retire')
			end

			within("#accessory-#{@accessory2.id}") do
				expect(page).to have_content(@accessory2.name)
				expect(page).to have_content(@accessory2.description)
				expect(page).to have_content(@accessory2.price)
				expect(page).to have_content('Retired')
				expect(page).to have_content('Edit')
				expect(page).to have_content('Reactivate')
			end
		end
		it 'allows me to click a link to change activation status' do
			visit admin_bike_shop_path

			within("#accessory-#{@accessory1.id}") do
				click_link 'Retire'
			end

			expect(current_path).to eq(admin_bike_shop_path)

			within("#accessory-#{@accessory1.id}") do
				expect(page).to have_content('Retired')
			end

			within("#accessory-#{@accessory2.id}") do
				click_link 'Reactivate'
			end

			expect(current_path).to eq(admin_bike_shop_path)

			within("#accessory-#{@accessory2.id}") do
				expect(page).to have_content('Active')
			end
		end
	end
end