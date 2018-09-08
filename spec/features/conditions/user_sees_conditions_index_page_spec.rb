require 'rails_helper'

describe 'user visits index page' do
  it "show all conditions and attributes" do
    condition_1 = Condition.create(
      date: Date.new(2018, 4, 29),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 30.0,
      mean_visibility: 15.0,
      mean_wind_speed: 9.0,
      precipitation: 0.01)

    condition_2 = Condition.create(
      date: Date.new(2018, 4, 30),
      max_temperature: 80.0,
      mean_temperature: 60.0,
      min_temperature: 40.0,
      mean_humidity: 20.0,
      mean_visibility: 9.0,
      mean_wind_speed: 8.0,
      precipitation: 0.43)

    visit conditions_path

    expect(page).to have_link("#{condition_1.date.strftime('%m/%d/%Y')}")
    expect(page).to have_link("#{condition_2.date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("Max temperature: #{condition_1.max_temperature}")
    expect(page).to have_content("Max temperature: #{condition_2.max_temperature}")
    expect(page).to have_content("Max temperature: #{condition_1.max_temperature}")
    expect(page).to have_content("Max temperature: #{condition_2.max_temperature}")
    expect(page).to have_content("Mean temperature: #{condition_1.mean_temperature}")
    expect(page).to have_content("Mean temperature: #{condition_2.mean_temperature}")
    expect(page).to have_content("Mean temperature: #{condition_1.mean_temperature}")
    expect(page).to have_content("Mean temperature: #{condition_2.mean_temperature}")
    expect(page).to have_content("Min temperature: #{condition_1.min_temperature}")
    expect(page).to have_content("Min temperature: #{condition_2.min_temperature}")
    expect(page).to have_content("Min temperature: #{condition_1.min_temperature}")
    expect(page).to have_content("Min temperature: #{condition_2.min_temperature}")
    expect(page).to have_content("Mean_humidity: #{condition_1.mean_humidity}")
    expect(page).to have_content("Mean_humidity: #{condition_2.mean_humidity}")
    expect(page).to have_content("Mean_humidity: #{condition_1.mean_humidity}")
    expect(page).to have_content("Mean_humidity: #{condition_2.mean_humidity}")
    expect(page).to have_content("Mean_visibility: #{condition_1.mean_visibility}")
    expect(page).to have_content("Mean_visibility: #{condition_2.mean_visibility}")
    expect(page).to have_content("Mean_visibility: #{condition_1.mean_visibility}")
    expect(page).to have_content("Mean_visibility: #{condition_2.mean_visibility}")
    expect(page).to have_content("Mean_wind_speed: #{condition_1.mean_wind_speed}")
    expect(page).to have_content("Mean_wind_speed: #{condition_2.mean_wind_speed}")
    expect(page).to have_content("Mean_wind_speed: #{condition_1.mean_wind_speed}")
    expect(page).to have_content("Mean_wind_speed: #{condition_2.mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{condition_1.precipitation}")
    expect(page).to have_content("Precipitation: #{condition_2.precipitation}")
    expect(page).to have_content("Precipitation: #{condition_1.precipitation}")
    expect(page).to have_content("Precipitation: #{condition_2.precipitation}")
  end
end
