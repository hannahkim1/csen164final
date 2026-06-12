class WishlistItemsController < ApplicationController
  # requires the cart to be set 
  include CurrentCart

  before_action :require_login
  before_action :set_cart

  def index
    @wishlist_items = current_user.wishlist_items.includes(:product).order(created_at: :desc)
  end

  # move the cart item to the wishlist, how to add to wishlist
  def create
    cartitem = @cart.cartitems.find(params[:cartitem_id])
    item = current_user.wishlist_items.find_by(product: cartitem.product)

    # add quantity if alr in wishlist
    if item
      item.quantity += cartitem.quantity
    else
      item = current_user.wishlist_items.build(product: cartitem.product, quantity: cartitem.quantity)
    end

    # save in wishlist
    item.save!
    cartitem.destroy!
    redirect_back fallback_location: wishlist_items_path, notice: "Saved for later."
  end

  # moving the wishlist item to the cart
  def move_to_cart
    item = current_user.wishlist_items.find(params[:id])
    cartitem = @cart.cartitems.find_by(product: item.product)
    if cartitem
      cartitem.quantity += item.quantity
    else
      cartitem = @cart.cartitems.build(product: item.product, quantity: item.quantity)
    end
    cartitem.save!
    item.destroy!
    redirect_to wishlist_items_path, notice: "Moved to cart."
  end

  def destroy
    item = current_user.wishlist_items.find(params[:id])
    item.destroy!
    redirect_to wishlist_items_path, notice: "Removed from wishlist.", status: :see_other
  end
end
