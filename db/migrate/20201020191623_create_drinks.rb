class CreateDrinks < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :category
      t.string :product_code
      t.string :price
      t.string :volume
      t.string :image_url

      t.timestamps
    end
  end
end
