require 'rails_helper'

describe "user visits index page" do
  it "shows all stations and attributes" do
    station_1 = Station.create(name:"Oglevie", dock_count: 45, city: "West Loop", installation_date: Date.new(2018, 9, 8))
    station_2 = Station.create(name:"Dugans", dock_count: 10, city: "West Loop", installation_date: Date.new(2018, 9, 8))
    station_3 = Station.create(name:"D4", dock_count: 20, city: "Streeterville", installation_date: Date.new(2018, 9, 8))
    station_4 = Station.create(name:"Reggies", dock_count: 30, city: "South Loop", installation_date: Date.new(2018, 9, 8))

    visit stations_path

    expect(page).to have_content(station_1.name)
    expect(page).to have_content(station_2.name)
    expect(page).to have_content(station_3.name)
    expect(page).to have_content(station_4.name)
    expect(page).to have_content("#{station_1.dock_count}")
    expect(page).to have_content("#{station_2.dock_count}")
    expect(page).to have_content("#{station_3.dock_count}")
    expect(page).to have_content("#{station_4.dock_count}")
    expect(page).to have_content(station_1.city)
    expect(page).to have_content(station_2.city)
    expect(page).to have_content(station_3.city)
    expect(page).to have_content(station_4.city)
    expect(page).to have_content(station_1.installation_date.strftime('%m/%d/%Y'))
    expect(page).to have_content(station_2.installation_date.strftime('%m/%d/%Y'))
    expect(page).to have_content(station_3.installation_date.strftime('%m/%d/%Y'))
    expect(page).to have_content(station_4.installation_date.strftime('%m/%d/%Y'))

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete")
    expect(page).to_not have_content("Add Station")
  end
end
