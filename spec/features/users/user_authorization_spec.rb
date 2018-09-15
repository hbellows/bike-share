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
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit admin_stations_path

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end

    describe "as a logged in user" do
      it 'prevents me from seeing another users private details' do
        user_1, user_2 = create_list(:user, 2)
        order_1 = user_1.orders.create(status: 'paid', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)
        order_2 = user_2.orders.create(status: 'pending', street_address: '120th St', city: 'Denver', state: 'CO', zip_code: 80401)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit order_path(user_1.orders.last)

        expect(current_path).to eq(order_path(user_1.orders.last))

        visit order_path(user_2.orders.last)

        expect(current_path).to eq(root_path)
      end
      it 'can edit my own details, but not other users details' do
        user = User.create(email: 'xyz@gmale.com', username: "firstname", password: 'test')
        user_2 = User.create(email: 'notauthorized', username: "shouldntbehere", password: 'test')

        visit root_path

        click_on 'Login'

        expect(current_path).to eq(login_path)

        fill_in :username, with: user.username
        fill_in :password, with: user.password

        click_on "Log In"

        expect(current_path).to eq(dashboard_path)

        click_on 'Edit Profile'

        expect(current_path).to eq(edit_user_path(user))
        fill_in :user_email, with: "different@gmale.com"
        fill_in :user_username, with: "differentname"
        fill_in :user_password, with: 'testagain'
        fill_in :user_password_confirmation, with: 'testagain'

        click_on "Update User"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Logged in as differentname")
      end
      it 'can edit my own details, but not other users details' do
        user_1 = User.create(email: 'xyz@gmale.com', username: "firstname", password: 'test')
        user_2 = User.create(email: 'notauthorized', username: "shouldntbehere", password: 'test')

        visit root_path

        click_on 'Login'

        expect(current_path).to eq(login_path)

        fill_in :username, with: user_1.username
        fill_in :password, with: user_1.password

        click_on "Log In"

        visit edit_user_path(user_2)

        expect(page).to have_content("Edit #{user_1.username}'s Account")
        expect(page).to_not have_content("Edit #{user_2.username}'s Account")
      end
    end
    describe "as an admin user" do
      it 'logs me in as an admin' do
        admin = User.create(email: 'xyz@gmale.com', username: "admin", password: 'test', role: 1)

        visit root_path

        click_on 'Login'

        expect(current_path).to eq(login_path)

        fill_in :username, with: admin.username
        fill_in :password, with: admin.password

        click_on "Log In"

        expect(page).to have_content("Logged in as ADMIN:#{admin.username}")
        page.has_link?(admin_orders_path)
        page.has_link?(admin_accessories_path)
      end
      it 'can edit my own details' do
        admin = User.create(email: 'xyz@gmale.com', username: "admin", password: 'test', role: 1)
        user = User.create(email: 'registereduser', username: "registereduser", password: 'test', password_confirmation: 'test')

        visit root_path

        click_on 'Login'

        expect(current_path).to eq(login_path)

        fill_in :username, with: admin.username
        fill_in :password, with: admin.password

        click_on "Log In"

        expect(current_path).to eq(admin_dashboard_path)

        click_on 'Edit Profile'

        expect(current_path).to eq(edit_admin_user_path(admin))
        fill_in :user_email, with: "differentadmin@gmale.com"
        fill_in :user_username, with: "differentnameadmin"
        fill_in :user_password, with: 'testagain'
        fill_in :user_password_confirmation, with: 'testagain'

        click_on "Update User"

        expect(current_path).to eq(admin_dashboard_path)
      end
      it 'can edit other users details' do
        admin = User.create(email: 'xyz@gmale.com', username: "admin", password: 'test', role: 1)
        user = User.create(email: 'registereduser', username: "registereduser", password: 'test', password_confirmation: 'test')

        visit root_path

        click_on 'Login'

        expect(current_path).to eq(login_path)

        fill_in :username, with: admin.username
        fill_in :password, with: admin.password

        click_on "Log In"

        visit edit_user_path(user)

        expect(page).to have_content("Edit #{user.username}'s Account")
      end
    end
  end
