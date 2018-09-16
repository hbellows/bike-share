require 'rails_helper'

describe 'Admin Condition Show Page' do
  describe 'as an admin user when I visit a condition show page' do
    it 'shows me the details of the weather condition with edit and delete links' do
      admin = create(:user, role: 1)
      condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit condition_path(condition)

      expect(page).to have_content("#{condition.date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{condition.max_temperature}")
      expect(page).to have_content("#{condition.mean_temperature}")
      expect(page).to have_content("#{condition.min_temperature}")
      expect(page).to have_content("#{condition.mean_humidity}")
      expect(page).to have_content("#{condition.mean_visibility}")
      expect(page).to have_content("#{condition.mean_wind_speed}")

      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end
    it 'allows me to edit a condition' do
    end
  end
end
