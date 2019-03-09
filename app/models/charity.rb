class Charity < ApplicationRecord
  has_many :news_posts, dependent: :destroy
  has_many :user_charities, dependent: :destroy
  has_many :charity_categories, dependent: :destroy

  validates :organization_name, presence: true
  validates :tax_id, presence: true
  validates :contact_email, presence: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
