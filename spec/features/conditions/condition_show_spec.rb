require 'rails_helper'

feature 'Condition show page' do
  context 'when a user visits a condition show page' do
    it 'shows all condition information' do

    condition = Condition.create(
      date: Date.new(2018, 4, 29),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 30.0,
      mean_visibility: 15.0,
      mean_wind_speed: 9.0,
      precipitation: 0.01)

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
      expect(page).to_not have_link("Edit")
      expect(page).to_not have_link("Delete")
    end
  end
end
