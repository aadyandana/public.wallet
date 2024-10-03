class Session < ApplicationRecord
  SESSION_TYPE_ACCESS = "ACCESS"
  SESSION_TYPE_REFRESH = "REFRESH"

  validates :session_type, inclusion: { in: %w[ACCESS REFRESH] }

  belongs_to :wallet

  scope :active, -> { where("expired_at >= ?", Time.current) }
  scope :access, -> { where(session_type: SESSION_TYPE_ACCESS) }
  scope :refresh, -> { where(session_type: SESSION_TYPE_REFRESH) }

  before_create :set_expired_at
  after_create :clear_expired

  def set_expired_at
    expired_at = Time.current
    expired_at += self.session_type == SESSION_TYPE_REFRESH ? 2.weeks : 30.minutes

    self.expired_at = expired_at
  end

  def clear_expired
    Session.where("expired_at < ?", Time.current).delete_all
  end
end
