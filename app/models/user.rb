class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_products, through: :favorites, source: :product
  has_many :orders, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "may only contain letters, numbers, and underscores" }

  before_validation :normalize_username

  def favorite_for(product)
    favorites.find_by(product: product)
  end

  private

  def normalize_username
    self.username = username.to_s.strip.downcase
  end
end
