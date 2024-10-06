class Session < ApplicationRecord
  validates :session_type, inclusion: { in: [ SessionType::ACCESS, SessionType::REFRESH ] }

  belongs_to :wallet

  scope :active, -> { where("expired_at >= ?", Time.current) }
  scope :access, -> { where(session_type: SessionType::ACCESS) }
  scope :refresh, -> { where(session_type: SessionType::REFRESH) }

  before_create :set_expired_at
  after_create :clear_expired

  def set_expired_at
    expired_at = Time.current
    expired_at += self.session_type == SessionType::REFRESH ?
      Rails.application.config.session_refresh_token_duration :
      Rails.application.config.session_access_token_duration

    self.expired_at = expired_at
  end

  def clear_expired
    Session.where("expired_at < ?", Time.current).delete_all
  end
end
