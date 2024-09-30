class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.string :owner_type
      t.decimal :balance, null: false, default: 0

      t.timestamps
    end
  end
end
