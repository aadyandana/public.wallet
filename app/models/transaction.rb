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
      self.sender_wallet.balance = total_amount(self.sender_wallet_id) - self.amount
      self.sender_wallet.save!
    end

    if self.receiver_wallet_id.present?
      self.receiver_wallet.balance = total_amount(self.receiver_wallet_id) + self.amount
      self.receiver_wallet.save!
    end
  end

  def total_credit_amount(wallet_id)
    Transaction.where(receiver_wallet_id: wallet_id).sum(:amount)
  end

  def total_debit_amount(wallet_id)
    Transaction.where(sender_wallet_id: wallet_id).sum(:amount)
  end

  def total_amount(wallet_id)
    total_credit_amount(wallet_id) - total_debit_amount(wallet_id)
  end
end
