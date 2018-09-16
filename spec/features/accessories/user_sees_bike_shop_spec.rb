require 'rails_helper'

describe "user visits bike shop page" do
  context "as a visitor" do
    it "shows all accessories and their attributes" do
      accessory_1 = create(:accessory)
      accessory_2 = create(:accessory)


      visit bike_shop_path

      expect(page).to have_content(accessory_1.name)
      expect(page).to have_content(accessory_1.description)
      expect(page).to have_content("$#{accessory_1.price}")
      expect(page).to have_content(accessory_2.name)
      expect(page).to have_content(accessory_2.description)
      expect(page).to have_content("$#{accessory_2.price}")
    end
    it "shows button to add to cart" do
      accessory_1 = create(:accessory)

      visit bike_shop_path

      expect(page).to have_button("Add to Cart")

      click_on "Add to Cart"

      expect(page).to have_content("You now have 1 item of #{accessory_1.name} in your cart")
    end
  end
end
