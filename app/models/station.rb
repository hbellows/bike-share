class Station < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date
end
