class Accessory < ApplicationRecord
  validates :name, :price, :description, :image, presence: true
end
