class Order < ApplicationRecord
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ].freeze

  belongs_to :user
  has_many :cartitems, dependent: :destroy

  validates :name, :email, :pay_type, presence: true
  validates :pay_type, inclusion: { in: PAYMENT_TYPES }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def add_cartitems_from_cart(cart)
    cart.cartitems.each do |item|
      item.cart_id = nil
      cartitems << item
    end
  end

  def total_price
    cartitems.to_a.sum(&:item_total_price)
  end
end
