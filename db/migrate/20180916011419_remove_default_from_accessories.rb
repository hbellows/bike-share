class RemoveDefaultFromAccessories < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :accessories, :image, nil
  end
end
