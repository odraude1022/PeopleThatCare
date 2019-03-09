class User < ApplicationRecord
  has_many :user_charities
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
