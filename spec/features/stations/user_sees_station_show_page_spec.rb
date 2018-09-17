require 'rails_helper'

describe 'As a user' do
  describe 'When I visit a station show page' do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      @station = create(:station)
      @terminal_station = create(:station)
      create_list(:trip, 5, start_station_id: @station.id, end_station_id: @terminal_station.id)
      create_list(:trip, 8, start_station_id: @terminal_station.id, end_station_id: @station.id)
    end
    it 'displays number of rides started at this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Rides Started Here: #{@station.number_rides_started}")
    end
    it 'displays number of rides ended at this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Rides Ended Here: #{@station.number_rides_ended}")
    end
    it 'displays most frequent destination station for this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Most Frequent Destination Station: #{@station.most_frequent_destination}")
    end
    it 'displays most frequent origination station for this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Most Frequent Origination Station: #{@station.most_frequent_origination}")
    end
    it 'displays the date with highest number of trips started at this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Date With Most Trips Started Here: #{@station.date_for_most_trips_started}")
    end
    it 'displays most frequent zip code for users starting at this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Most Frequent Zipcode For Users Starting Here: #{@station.top_starting_user_zipcode}")
    end
    it 'displays the Bike ID most frequently starting a trip at this station' do
      visit "/#{@station.slug}"

      expect(page).to have_content("Bike ID Most Frequently Starting Here: #{@station.top_starting_bike_id}")
    end
  end
end
