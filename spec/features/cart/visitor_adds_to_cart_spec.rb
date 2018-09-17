require 'rails_helper'

describe 'visitor/user can view accessories in cart' do
  before(:each) do
    @accessory_1 = create(:accessory, price: 10.00)
    @accessory_2 = create(:accessory, price: 11.00)
  end
  describe 'not logged in with accessories in cart' do
    it 'should display accessories in cart' do

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      2.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_1.id}-quantity") do
        expect(page).to have_content("1")
      end
      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_2.id}-quantity") do
        expect(page).to have_content("2")
      end
      expect(page).to have_content("Total: $32.00")
    end
  end

  describe 'logged in with accessories in cart' do
    it 'should display existing accessories in cart' do
      user = create(:user)

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      2.times do
        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_1.id}-quantity") do
        expect(page).to have_content("1")
      end
      expect(page).to have_content(@accessory_2.name)
      expect(page).to have_content(@accessory_2.price)
      within("#accessory-#{@accessory_2.id}-quantity") do
        expect(page).to have_content("2")
      end
      expect(page).to have_content("Total: $32.00")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_1.id}-quantity") do
        expect(page).to have_content("1")
      end
      expect(page).to have_content(@accessory_2.name)
      expect(page).to have_content(@accessory_2.price)
      within("#accessory-#{@accessory_2.id}-quantity") do
        expect(page).to have_content("2")
      end
      expect(page).to have_content("Total: $32.00")
    end
  end

  describe "visitor adds one more of the same accessory" do
    it 'should be able to add an additional Quantity' do
      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end


      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_1.id}-quantity") do
        expect(page).to have_content("1")
      end
      expect(page).to have_content("Total: $10.00")

      visit bike_shop_path

      within("#accessory-#{@accessory_1.id}") do
        click_button 'Add to Cart'
      end

      visit '/cart'

      expect(page).to have_content(@accessory_1.name)
      expect(page).to have_content(@accessory_1.price)
      within("#accessory-#{@accessory_1.id}-quantity") do
        expect(page).to_not have_content("1")
        expect(page).to have_content("2")
      end
      expect(page).to have_content("Total: $20.00")
    end

    describe 'When a visitor adds accessories to cart' do
      it 'a message is displayed' do
        visit bike_shop_path

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 1 item of #{@accessory_2.name} in your cart")
      end
      it 'a message correctly increments for multiple accessories' do
        visit bike_shop_path

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 1 item of #{@accessory_2.name} in your cart")

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("You now have 2 items of #{@accessory_2.name} in your cart")
      end
      it 'total number of accessories in cart increments' do
        visit bike_shop_path

        expect(page).to have_content("Cart: 0")

        within("#accessory-#{@accessory_2.id}") do
          click_button 'Add to Cart'
        end

        expect(page).to have_content("Cart: 1")
      end
      describe "visitor increases one of the same accessory" do
        it 'should show cart with accessory increased' do
          visit bike_shop_path

          within("#accessory-#{@accessory_1.id}") do
            click_button 'Add to Cart'
          end

          3.times do
            within("#accessory-#{@accessory_2.id}") do
              click_button 'Add to Cart'
            end
          end

          visit '/cart'

          expect(page).to have_content(@accessory_1.name)
          expect(page).to have_content(@accessory_1.price)
          expect(page).to have_content(@accessory_2.name)
          expect(page).to have_content(@accessory_2.price)
          within("#accessory-#{@accessory_1.id}-quantity") do
            expect(page).to have_content("1")
          end
          within("#accessory-#{@accessory_2.id}-quantity") do
            expect(page).to have_content("3")
          end
          expect(page).to have_content("Total: $43.00")


          within("#accessory-#{@accessory_2.id}") do
            click_button 'increase quantity'
          end

          within("#accessory-#{@accessory_1.id}-quantity") do
            expect(page).to have_content("1")
          end
          within("#accessory-#{@accessory_2.id}-quantity") do
            expect(page).to have_content("4")
          end
          expect(page).to have_content("Total: $54.00")
        end
      end
    end
  end
end
