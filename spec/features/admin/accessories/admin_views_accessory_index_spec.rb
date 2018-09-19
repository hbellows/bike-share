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
				expect(page).to have_link(@accessory1.name, href: accessory_path(@accessory1))
				expect(page).to have_content(@accessory1.description)
				expect(page).to have_content(@accessory1.price)
				expect(page).to have_content('Edit')
				expect(page).to have_button('Retire')
			end

			within("#accessory-#{@accessory2.id}") do
				expect(page).to have_link(@accessory2.name, href: accessory_path(@accessory2))
				expect(page).to have_content(@accessory2.description)
				expect(page).to have_content(@accessory2.price)
				expect(page).to have_content('Edit')
				expect(page).to have_button('Reactivate')
			end
		end
		it 'allows me to click a link to change activation status' do
			visit admin_bike_shop_path

			within("#accessory-#{@accessory1.id}") do
				click_button 'Retire'
			end

			expect(current_path).to eq(admin_bike_shop_path)

			within("#accessory-#{@accessory1.id}") do
				expect(page).to have_button('Reactivate')
			end

			within("#accessory-#{@accessory2.id}") do
				click_button 'Reactivate'
			end

			expect(current_path).to eq(admin_bike_shop_path)

			within("#accessory-#{@accessory2.id}") do
				expect(page).to have_button('Retire')
			end
		end
	end
end