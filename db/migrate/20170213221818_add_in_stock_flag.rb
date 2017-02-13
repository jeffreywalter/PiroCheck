class AddInStockFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :in_stock, :boolean, default: false
  end
end
