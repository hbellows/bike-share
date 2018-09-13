require 'rails_helper'

describe 'As an admin' do
  before(:each) do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    @station1 = create(:station)
    @station2 = create(:station)
  end
  describe 'When I visist the admin station index page' do
    it 'allows me to delete a station' do
      visit admin_stations_path

      within("#station-#{@station1.id}") do
        click_link 'Delete'
      end

      expect(current_path).to eq(admin_stations_path)
      expect(page).to have_content('Station deleted.')
      expect(page).to have_content(@station2.name)
      expect(page).to_not have_content(@station1.name)
    end
  end
end
