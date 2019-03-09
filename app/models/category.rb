class Category < ApplicationRecord
  has_many :charity_categories, dependent: :destroy
  validates :category_name, presence: true
end
