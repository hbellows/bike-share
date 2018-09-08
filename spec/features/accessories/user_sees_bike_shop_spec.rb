require 'rails_helper'

describe "user visits bike shop page" do
  context "as a visitor" do
    it "shows all accessories and their attributes" do
      accessory_1 = Accessory.create(title: 'Gold Pedal', description: 'for added performance and beautiful bling bling', price: 900.00)
      accessory_2 = Accessory.create(title: "Kid's bell", description: 'In case they didnt see you already, ring this cute bell', price: 11.00)

      visit bike_shop_path

      expect(page).to have_content(accessory_1.title)
      expect(page).to have_content(accessory_1.description)
      expect(page).to have_content("Price: #{accessory_1.price}")
      expect(page).to have_content(accessory_2.title)
      expect(page).to have_content(accessory_2.description)
      expect(page).to have_content("Price: #{accessory_2.price}")
    end
  end
end
