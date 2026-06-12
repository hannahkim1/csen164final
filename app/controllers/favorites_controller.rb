class FavoritesController < ApplicationController
  # same as reviews controller
  before_action :require_login

  def index
    @favorites = current_user.favorited_products.order(:name)
  end

  def create
    product = Product.find(params[:product_id])
    current_user.favorites.find_or_create_by!(product: product)
    redirect_back fallback_location: product, notice: "Added to favorites."
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    product = favorite.product
    favorite.destroy!
    redirect_back fallback_location: product, notice: "Removed from favorites.", status: :see_other
  end
end
