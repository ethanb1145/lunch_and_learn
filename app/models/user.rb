class User < ApplicationRecord
  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  has_secure_password
end