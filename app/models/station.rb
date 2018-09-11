class Station < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

  extend FriendlyId
  friendly_id :name, :use => :slugged

  def self.total_count
    count
  end

  def self.average_bikes_per_station
    average(:dock_count).round(1)
  end

  def self.most_bikes_per_station
    order(:dock_count).last
  end

  def self.least_bikes_per_station
    order(:dock_count).first
  end


end
