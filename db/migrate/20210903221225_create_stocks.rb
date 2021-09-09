class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :company
      t.string :ticker
      t.integer :current_price
      t.integer :market_cap

      t.timestamps
    end
  end
end
