require 'rails_helper'

describe 'As an admin' do
	describe 'When I visit accessory show as admin' do
		before(:each) do
			admin = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
			@accessory1 = create(:accessory)
			@accessory2 = create(:accessory, retired?: true)
		end
		it 'shows me the accessory' do

			visit accessory_path(@accessory1)

			expect(page).to have_content(@accessory1.name)
			expect(page).to have_content(@accessory1.description)
			expect(page).to have_content(@accessory1.price)
			expect(page).to have_button('Retire')
			expect(page).to_not have_button('Reactivate')
			expect(page).to have_button('Add to Cart')

			visit accessory_path(@accessory2)

			expect(page).to have_content(@accessory2.name)
			expect(page).to have_content(@accessory2.description)
			expect(page).to have_content(@accessory2.price)
			expect(page).to_not have_button('Retire')
			expect(page).to have_button('Reactivate')
			expect(page).to_not have_button('Add to Cart')
		end
		it 'I can retire and reactivate accessory' do
		accessory = create(:accessory)

		visit accessory_path(accessory)

		expect(page).to have_content(accessory.name)
		expect(page).to have_content(accessory.description)
		expect(page).to have_content(accessory.price)
		expect(page).to have_button('Retire')
		expect(page).to_not have_button('Reactivate')
		expect(page).to have_button('Add to Cart')

		click_on 'Retire'

		expect(current_path).to eq(accessory_path(accessory))
		expect(page).to have_content(accessory.name)
		expect(page).to_not have_button('Retire')
		expect(page).to have_button('Reactivate')
		expect(page).to_not have_button('Add to Cart')

		click_on "Reactivate"

		expect(current_path).to eq(accessory_path(accessory))
		expect(page).to have_content(accessory.name)
		expect(page).to have_button('Retire')
		expect(page).to_not have_button('Reactivate')
		expect(page).to have_button('Add to Cart')
		end
		it 'allows me to click a link to change activation status' do
			visit admin_bike_shop_path

			within("#accessory-#{@accessory1.id}") do
				click_button 'Retire'
			end

			expect(current_path).to eq(admin_bike_shop_path)
		end
	end
end
