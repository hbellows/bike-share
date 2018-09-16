require 'rails_helper'

describe 'Admin Condition Index Page' do
  describe 'as an admin when I visit the condition index page' do
    it 'should show me all conditions with a link to edit or delete a condition' do
      admin = create(:user, role: 1)
      condition1 = create(:condition)
      condition2 = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      expect(page).to have_content("#{condition1.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{condition1.max_temperature}")
      expect(page).to have_content("#{condition1.mean_temperature}")
      expect(page).to have_content("#{condition1.min_temperature}")
      expect(page).to have_content("#{condition1.mean_humidity}")
      expect(page).to have_content("#{condition1.mean_visibility}")
      expect(page).to have_content("#{condition1.mean_wind_speed}")
      expect(page).to have_content("#{condition1.precipitation}")

      expect(page).to have_content("#{condition2.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{condition2.max_temperature}")
      expect(page).to have_content("#{condition2.mean_temperature}")
      expect(page).to have_content("#{condition2.min_temperature}")
      expect(page).to have_content("#{condition2.mean_humidity}")
      expect(page).to have_content("#{condition2.mean_visibility}")
      expect(page).to have_content("#{condition2.mean_wind_speed}")
      expect(page).to have_content("#{condition2.precipitation}")

      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end
    it 'allows an admin to create a new condition' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_condition_path

      fill_in :condition_date, with: "2018/09/12"
      fill_in :condition_max_temperature, with: 80
      fill_in :condition_mean_temperature, with: 60
      fill_in :condition_min_temperature, with: 50
      fill_in :condition_mean_humidity, with: 34.0
      fill_in :condition_mean_visibility, with: 10
      fill_in :condition_mean_wind_speed, with: 4
      fill_in :condition_precipitation, with: 0.05

      click_on "Create Condition"

      expect(current_path).to eq(new_admin_conditions_path)
      expect(page).to have_content("09/12/2018")
      expect(page).to have_content("80")
      expect(page).to have_content("60")
      expect(page).to have_content("50")
      expect(page).to have_content("34")
      expect(page).to have_content("10")
      expect(page).to have_content("4")
      expect(page).to have_content("0.05")
    end
  end
end

# As a admin user, When I visit admin condition new, 
# I fill in a form with all condition attributes, 
# When I click "Create Condition", I am directed to a that condition's show page. 
# I also see a flash message that I have created that condition.  
# ** All Attributes must be present **
