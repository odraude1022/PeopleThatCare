class User < ApplicationRecord
  has_many :user_charities
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
