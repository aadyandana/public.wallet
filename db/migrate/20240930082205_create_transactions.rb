class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :sender_wallet, null: true, foreign_key: { to_table: :wallets }
      t.references :receiver_wallet, null: true, foreign_key: { to_table: :wallets }
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
