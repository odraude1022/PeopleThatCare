class NewsPost < ApplicationRecord
  belongs_to :charity
  validates :title, presence: true
  validates :text, presence: true

end
