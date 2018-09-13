class ChangeDateColumnStations < ActiveRecord::Migration[5.1]
  def change
    change_column :stations, :installation_date, :date
  end
end
