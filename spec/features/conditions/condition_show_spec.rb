require 'rails_helper'

feature 'Condition show page' do
  context 'when a user visits a condition show page' do
    it 'shows all condition information' do
      condition = create(:condition)

      visit condition_path(condition)

      expect(page).to have_content(condition.date.strftime('%m/%d/%Y'))
      expect(page).to have_content(condition.max_temperature)
      expect(page).to have_content(condition.mean_temperature)
      expect(page).to have_content(condition.min_temperature)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility)
      expect(page).to have_content(condition.mean_wind_speed)

      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
      expect(page).to_not have_button("Edit")
      expect(page).to_not have_button("Delete")
    end
  end
end
