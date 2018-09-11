class OrderAccessory < ApplicationRecord
  belongs_to :order
  belongs_to :accessory

  def accessory_name
    Accessory.find(accessory_id).name
  end

  def subtotal
    quantity * unit_price
  end
end
