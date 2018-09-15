class AddColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip_code, :integer
  end
end
