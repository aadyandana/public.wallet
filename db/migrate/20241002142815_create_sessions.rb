class CreateSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.string :type, null: false
      t.string :token, null: false
      t.timestamp :expired_at, null: false

      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end
