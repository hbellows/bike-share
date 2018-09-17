require 'rails_helper'

feature 'Trip index page' do
  context 'When a visitor visits page, they see all trips' do
    before(:each) do
      station_1, station_2 = create_list(:station, 2)

      31.times do
        create(:trip, start_station_id: station_1.id, end_station_id: station_2.id)
      end
    end
    it 'show visitor all info for the first 30 trips' do
      visit trips_path

      expect(page).to have_content("#{Trip.all[29].duration}")
      expect(page).to have_content("#{Trip.all[29].start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{Trip.all[29].end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{Trip.all[29].start_station_id}")
      expect(page).to have_content("#{Trip.all[29].end_station_id }")
      expect(page).to have_content("#{Trip.all[29].bike_id}")
      expect(page).to have_content("#{Trip.all[29].subscription_type}")
      expect(page).to have_content("#{Trip.all[29].zip_code}")

      expect(page).to_not have_content("Bike id: #{Trip.all.last.bike_id}")

      expect(page).to have_content('1')
      expect(page).to have_content('Previous')
      expect(page).to have_link('2')
      expect(page).to have_link('Next')
    end
    it 'should show thirty first trip on the next page' do
      visit trips_path

      click_on "Next"

      expect(page).to have_content("#{Trip.all.last.bike_id}")
    end
  end
end
