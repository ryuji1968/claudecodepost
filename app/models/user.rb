class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  PASSWORD_RESET_EXPIRATION = 15.minutes

  def password_reset_token
    signed_id(purpose: :password_reset, expires_in: PASSWORD_RESET_EXPIRATION)
  end

  def password_reset_token_expires_in
    PASSWORD_RESET_EXPIRATION
  end

  def self.find_by_password_reset_token!(token)
    find_signed!(token, purpose: :password_reset)
  end
end
