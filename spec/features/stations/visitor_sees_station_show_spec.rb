require 'rails_helper'

feature 'When a visitor visits the station show page' do
  scenario 'they see all attributes of that station' do
   station = Station.create(name: 'San Jose Diridon Caltrain Station', lattitude: 37.329732, longitude: -121.90178200000001, dock_count: 27, city: 'San Jose', installation_date: '8/6/2013' )

   visit "/:#{station.name.gsub(/[" "]/, '-')}"

   expect(page).to have_content(station.name)
   expect(page).to have_content(station.lattitude)
   expect(page).to have_content(station.longitude)
   expect(page).to have_content("Dock Count: #{station.dock_count}")
   expect(page).to have_content(station.city)
   expect(page).to have_content(station.installation_date)
  end
end
