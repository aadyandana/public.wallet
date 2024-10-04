class Wallet < ApplicationRecord
  has_many :credit_transactions, class_name: "Transaction", foreign_key: :receiver_wallet_id
  has_many :debit_transactions, class_name: "Transaction", foreign_key: :sender_wallet_id

  validates :owner_type, inclusion: { in: %w[USER TEAM STOCK] }
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_create :init_balance

  def init_balance
    self.balance = 0
  end

  def calculate_balance
    self.credit_transactions.sum(:amount) - self.debit_transactions.sum(:amount)
  end
end
