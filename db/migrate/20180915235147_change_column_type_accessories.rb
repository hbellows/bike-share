class ChangeColumnTypeAccessories < ActiveRecord::Migration[5.1]
  def change
  	change_column :accessories, :price, :float
  end
end
