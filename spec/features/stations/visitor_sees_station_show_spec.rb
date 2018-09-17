require 'rails_helper'

feature 'When a visitor visits the station show page' do
  scenario 'they see all attributes of that station' do
		station = create(:station)
		
		visit "/#{station.name.parameterize}"

   	expect(page).to have_content(station.name)
    expect(page).to have_content("#{station.dock_count}")
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date.strftime('%m/%d/%Y'))
  end
end
