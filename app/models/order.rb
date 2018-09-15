class Order < ApplicationRecord
  belongs_to :user

  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  scope :filter_by_status, -> status { where(status: status) }

  def self.status_count
    group(:status).count
  end

  def total
    order_accessories.sum("quantity * unit_price")
  end
end
