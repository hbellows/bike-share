require 'rails_helper'

feature 'Trip index page' do
  context 'When a visitor visits page, they see all trips' do
    before(:each) do
      station_1 = Station.create(name: 'San Jose Diridon Caltrain Station', dock_count: 27, city: 'San Jose', installation_date: Date.new(2014, 10, 17))
      station_2 = Station.create(name: 'Redwood City Muni', dock_count: 37, city: 'Redwood City', installation_date: Date.new(2016, 11, 26))

      duration = 0
      start_date = Date.new(2018, 5, 26)
      end_date = Date.new(2018, 1, 17)
      start_station_id = station_1.id
      end_station_id = station_2.id
      bike_id = 1
      subscription_type = 0
      zip_code = 60446

      30.times do
      Trip.create!(
        duration: duration += 1,
        start_date: start_date,
        end_date: end_date,
        start_station_id: start_station_id,
        end_station_id: end_station_id,
        bike_id: bike_id += 1,
        subscription_type: subscription_type,
        zip_code: zip_code += 1)
      end
    end

    it 'show visitor all info for the first 30 trips' do

      visit trips_path

      expect(page).to have_content("#{Trip.all.last.duration}")
      expect(page).to have_content("#{Trip.all.last.start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{Trip.all.last.end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{Trip.all.last.start_station_id}")
      expect(page).to have_content("#{Trip.all.last.end_station_id }")
      expect(page).to have_content("#{Trip.all.last.bike_id}")
      expect(page).to have_content("#{Trip.all.last.subscription_type}")
      expect(page).to have_content("#{Trip.all.last.zip_code}")
    end

    xit 'shows links for navigating between pages' do
      expect(page).to have_link
      expect(page).to_not have_content("")
      # click_on #button/link provided by pagenation gem to move to next page
      # expect(current_path).to eq()
      # expect(page).to have_xpath("//a")
    end
  end
end
