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
  end
end
