require 'rails_helper'

feature 'When a visitor visits the station show page' do
  scenario 'they see all attributes of that station' do
   station = Station.create(name: 'San Jose Diridon Caltrain Station', dock_count: 27, city: 'San Jose', installation_date: '8/6/2013' )

   visit "/#{station.name.parameterize}"
save_and_open_page
   expect(page).to have_content(station.name)
   expect(page).to have_content("Dock count: #{station.dock_count}")
   expect(page).to have_content(station.city)
   expect(page).to have_content(station.installation_date.strftime('%m/%d/%Y'))
  end
end
