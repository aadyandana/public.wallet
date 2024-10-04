class Transaction < ApplicationRecord
  attr_accessor :transaction_type

  belongs_to :sender_wallet, class_name: "Wallet", optional: true
  belongs_to :receiver_wallet, class_name: "Wallet", optional: true

  validates :sender_wallet, presence: true, unless: :top_up_transaction?
  validates :receiver_wallet, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  before_save :update_wallet

  def top_up_transaction?
    transaction_type == "top_up"
  end

  def update_wallet
    if self.sender_wallet_id.present?
      self.sender_wallet.balance = self.sender_wallet.calculate_balance - self.amount
      self.sender_wallet.save!
    end

    if self.receiver_wallet_id.present?
      self.receiver_wallet.balance = self.receiver_wallet.calculate_balance + self.amount
      self.receiver_wallet.save!
    end
  end
end
