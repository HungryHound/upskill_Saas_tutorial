class CreateCryptocurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :coin
      t.float :holding
      t.float :purchase_price

      t.timestamps
    end
  end
end
