class User < ApplicationRecord
  has_secure_password

  validates :username, :email, :role, presence: true, unless: :admin?
  validates_presence_of :full_name

  validates :password, presence: true, on: :create
  validates_confirmation_of :password, on: :create

  has_many :orders

  enum role: %i[default admin]
end
