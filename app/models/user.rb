class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { regular: 0, admin: 10 }

  validates :name, :last_name, :email_address, :password, :password_confirmation, presence: true
  validates :email_address, uniqueness: { case_sensitive: false }
  validates :email_address, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }
end
