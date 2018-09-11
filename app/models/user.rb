class User < ApplicationRecord
  has_secure_password

  validates :username, :email, :role, presence: true, unless: :admin?

  # validates_confirmation_of :password
  validates :password, presence: true, on: :create

  has_many :orders

  enum role: %i[default admin]
end
