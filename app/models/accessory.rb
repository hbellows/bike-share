class Accessory < ApplicationRecord
  validates :name, :price, :description, :image, presence: true
  validates_uniqueness_of :name

  has_many :order_accessories
  has_many :orders, through: :order_accessories
end
