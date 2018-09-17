require 'rails_helper'

describe 'user visits index page' do
  it "show all conditions and attributes" do
    condition_1 = create(:condition)
    condition_2 = create(:condition)

    visit conditions_path

    expect(page).to have_link("#{condition_1.date.strftime('%m/%d/%Y')}")
    expect(page).to have_link("#{condition_2.date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{condition_1.max_temperature}")
    expect(page).to have_content("#{condition_2.max_temperature}")
    expect(page).to have_content("#{condition_1.max_temperature}")
    expect(page).to have_content("#{condition_2.max_temperature}")
    expect(page).to have_content("#{condition_1.mean_temperature}")
    expect(page).to have_content("#{condition_2.mean_temperature}")
    expect(page).to have_content("#{condition_1.mean_temperature}")
    expect(page).to have_content("#{condition_2.mean_temperature}")
    expect(page).to have_content("#{condition_1.min_temperature}")
    expect(page).to have_content("#{condition_2.min_temperature}")
    expect(page).to have_content("#{condition_1.min_temperature}")
    expect(page).to have_content("#{condition_2.min_temperature}")
    expect(page).to have_content("#{condition_1.mean_humidity}")
    expect(page).to have_content("#{condition_2.mean_humidity}")
    expect(page).to have_content("#{condition_1.mean_humidity}")
    expect(page).to have_content("#{condition_2.mean_humidity}")
    expect(page).to have_content("#{condition_1.mean_visibility}")
    expect(page).to have_content("#{condition_2.mean_visibility}")
    expect(page).to have_content("#{condition_1.mean_visibility}")
    expect(page).to have_content("#{condition_2.mean_visibility}")
    expect(page).to have_content("#{condition_1.mean_wind_speed}")
    expect(page).to have_content("#{condition_2.mean_wind_speed}")
    expect(page).to have_content("#{condition_1.mean_wind_speed}")
    expect(page).to have_content("#{condition_2.mean_wind_speed}")
    expect(page).to have_content("#{condition_1.precipitation}")
    expect(page).to have_content("#{condition_2.precipitation}")
    expect(page).to have_content("#{condition_1.precipitation}")
    expect(page).to have_content("#{condition_2.precipitation}")

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
  end
end
