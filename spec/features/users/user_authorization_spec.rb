require 'rails_helper'

feature 'User authorization' do
  describe 'As a visitor' do
    describe 'when I visit any administrator pages' do
      it 'redirects to /login and gives me an error message' do
        visit admin_stations_path

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
  end
    describe 'as a logged in user, when I visit any administrator page' do
      it 'redirects to /login and gives me an error message' do
        user = create(:user, password: 'test')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit admin_stations_path

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
    describe "as a logged in user" do
      it 'prevents me from seeing another users private details' do
        user1 = create(:user, password: 'test')
        user2 = create(:user, password: 'test2')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit user_path(user2)

        expect(current_path).to eq(user_path(user1))
      end
    end
  end
