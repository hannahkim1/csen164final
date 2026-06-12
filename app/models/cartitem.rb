class Cartitem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product

  def item_total_price
    product.price * quantity
  end
  
end

