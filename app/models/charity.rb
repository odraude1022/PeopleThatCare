class Charity < ApplicationRecord
  has_many :news_posts, dependent: :destroy
  has_many :user_charities, dependent: :destroy
  has_many :charity_categories, dependent: :destroy

  validates :organization_name, presence: true
  validates :tax_id, presence: true, uniqueness: true
  validates :contact_email, presence: true, uniqueness: true
  validates :twitter_handle, uniqueness: true
  validates :website_url, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
