class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  normalizes :name, with: -> (name) { name.strip }
  normalizes :email, with: -> (email) { email.strip }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
end
