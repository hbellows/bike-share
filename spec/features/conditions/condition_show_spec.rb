=begin
As a visitor,
When I visit a condition show,
I see all attributes for that condition.
(Date, Max Temperature, Mean Temperature, Min Temperature, Mean Humidity,
Mean Visibility (in Miles), Mean Wind Speed (mph), Precipitation (inches))
** All Attributes must be present **

Each row represents the weather for a specific day and zip code in the bay area
=end



require 'rails_helper'

feature 'Condition show page' do
  scenario 'when a user visits a condition show page' do
    it 'shows all condition information' do
      condition = Condition.create(date: '8/29/2013', max_temperature_f: 99.0,
        mean_temperature_f: 75.0, min_temperature_f: 60.0, mean_humidity: 75.0,
        mean_visibility_miles: 10.0, mean_wind_speed_mph: 11.0,
        precipitation_inches: 0.01)

        visit condition_path(condition) #?

        expec(page).to have_content(condition.date)
        expec(page).to have_content(condition.max_temperature_f)
        expec(page).to have_content(condition.mean_temperature_f)
        expec(page).to have_content(condition.min_temperature_f)
        expec(page).to have_content(condition.mean_humidity)
        expec(page).to have_content(condition.mean_visibility)
        expec(page).to have_content(condition.mean_wind_speed)
    end
  end
end
