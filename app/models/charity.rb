class Charity < ApplicationRecord
  attr_accessor :remember_token
  has_one_attached :avatar
  has_many :news_posts, dependent: :destroy
  has_many :user_charities, dependent: :destroy
  has_many :charity_categories, dependent: :destroy
  has_many :categories, through: :charity_categories

  validates :organization_name, presence: true
  validates :tax_id, presence: true, uniqueness: true
  validates :contact_email, presence: true, uniqueness: true
  validates :twitter_handle, uniqueness: true
  validates :website_url, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  # Returns the hash digest of the given string.
  def Charity.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Charity.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Charity.new_token
    update_attribute(:remember_digest, Charity.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
