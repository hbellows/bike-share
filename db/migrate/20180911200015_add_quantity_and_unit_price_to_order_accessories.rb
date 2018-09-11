class AddQuantityAndUnitPriceToOrderAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :order_accessories, :quantity, :integer
    add_column :order_accessories, :unit_price, :float
  end
end
