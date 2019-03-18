class Category < ApplicationRecord
  has_many :charity_categories, dependent: :destroy
  has_many :charities, through: :charity_categories
  validates :category_name, presence: true, uniqueness: true
end
