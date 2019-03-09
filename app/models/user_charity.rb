class UserCharity < ApplicationRecord
  belongs_to :user
  belongs_to :charity

end
