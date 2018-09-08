class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :image
      t.boolean "retired?", default: false
      
      t.timestamps
    end
  end
end
