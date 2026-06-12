class WishlistItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, uniqueness: { scope: :product_id, message: "already has this product in the wishlist" }

  def item_total_price
    product.price * quantity
  end
end
