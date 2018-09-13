require 'rails_helper'

describe 'Admin Condition Index Page' do
  describe 'as an admin when I visit the condition index page' do
    it 'should show me all conditions with a link to edit or delete a condition' do
      admin = create(:user, role: 1)
      condition1 = create(:condition)
      condition2 = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_conditions_path

      expect(page).to have_content("Date: #{condition1.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("Max Temp: #{condition1.max_temperature}")
      expect(page).to have_content("Mean Temp: #{condition1.mean_temperature}")
      expect(page).to have_content("Min Temp: #{condition1.min_temperature}")
      expect(page).to have_content("Mean Humidity: #{condition1.mean_humidity}")
      expect(page).to have_content("Mean Visibility: #{condition1.mean_visibility}")
      expect(page).to have_content("Mean Wind Speed: #{condition1.mean_wind_speed}")
      expect(page).to have_content("Precipitation: #{condition1.precipitation}")

      expect(page).to have_content("Date: #{condition2.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("Max Temp: #{condition2.max_temperature}")
      expect(page).to have_content("Mean Temp: #{condition2.mean_temperature}")
      expect(page).to have_content("Min Temp: #{condition2.min_temperature}")
      expect(page).to have_content("Mean Humidity: #{condition2.mean_humidity}")
      expect(page).to have_content("Mean Visibility: #{condition2.mean_visibility}")
      expect(page).to have_content("Mean Wind Speed: #{condition2.mean_wind_speed}")
      expect(page).to have_content("Precipitation: #{condition2.precipitation}")

    end
  end
end
