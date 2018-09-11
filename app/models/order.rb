class Order < ApplicationRecord
  belongs_to :user

  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  def total
    order_accessories.sum("quantity * unit_price")
  end
end
