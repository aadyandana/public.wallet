class Wallet < ApplicationRecord
  validates :owner_type, inclusion: { in: %w[USER TEAM STOCK] }
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_create :init_balance

  def init_balance
    self.balance = 0
  end
end
