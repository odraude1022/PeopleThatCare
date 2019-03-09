class Charity < ApplicationRecord
  has_many :news_posts, dependent: :destroy
  has_many :user_charities, dependent: :destroy
  has_many :charity_categories, dependent: :destroy
end
