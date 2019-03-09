class Category < ApplicationRecord
  has_many :charity_categories, dependent: :destroy
end
