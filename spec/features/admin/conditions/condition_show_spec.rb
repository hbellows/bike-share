require 'rails_helper'

describe 'Admin Condition Show Page' do
  describe 'as an admin user when I visit a condition show page' do
    before(:each) do
      admin = create(:admin)
      @condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    end
    it 'shows me the details of the weather condition with edit and delete links' do
      visit condition_path(@condition)

      expect(page).to have_content("#{@condition.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{@condition.max_temperature}")
      expect(page).to have_content("#{@condition.mean_temperature}")
      expect(page).to have_content("#{@condition.min_temperature}")
      expect(page).to have_content("#{@condition.mean_humidity}")
      expect(page).to have_content("#{@condition.mean_visibility}")
      expect(page).to have_content("#{@condition.mean_wind_speed}")

      expect(page).to have_button("Edit")
      expect(page).to have_button("Delete")
    end
    it 'allows me to edit a condition' do
      visit edit_admin_condition_path(@condition)

      fill_in :condition_date, with: '09/13/2018'
      fill_in :condition_max_temperature, with: 80
      fill_in :condition_mean_temperature, with: 60
      fill_in :condition_min_temperature, with: 50
      fill_in :condition_mean_humidity, with: 34.0
      fill_in :condition_mean_visibility, with: 10
      fill_in :condition_mean_wind_speed, with: 4
      fill_in :condition_precipitation, with: 0.05

      click_on "Update Condition"

      expect(current_path).to eq(condition_path(@condition))
      expect(page).to have_content("09/13/2018")
      expect(page).to have_content("80")
      expect(page).to have_content("60")
      expect(page).to have_content("50")
      expect(page).to have_content("34")
      expect(page).to have_content("10")
      expect(page).to have_content("4")
      expect(page).to have_content("0.05")
    end
    it 'all attributes must be present to edit' do
      visit edit_admin_condition_path(@condition)

      fill_in :condition_date, with: '09/13/2018'
      fill_in :condition_max_temperature, with: ''
      fill_in :condition_mean_temperature, with: ''
      fill_in :condition_min_temperature, with: ''
      fill_in :condition_mean_humidity, with: 34.0
      fill_in :condition_mean_visibility, with: ''
      fill_in :condition_mean_wind_speed, with: ''
      fill_in :condition_precipitation, with: 0.05

      click_on "Update Condition"

      expect(current_path).to eq(edit_admin_condition_path(@condition))
      expect(page).to have_content('Condition was not updated.')
    end
  end
end
