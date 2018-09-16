class ChangeDefaultImageAccesories < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :accessories, :image, 'bike_image.jpg'
  end
end
