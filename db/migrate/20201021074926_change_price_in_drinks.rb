class ChangePriceInDrinks < ActiveRecord::Migration[6.0]
  def change
    change_column :drinks, :price, 'float USING CAST(price AS float)'
  end
end
