class ShopperController < ApplicationController
  include CurrentCart 
  before_action :set_cart 

  def index
    @query = params[:query]
    @sort = params[:sort]
    @products = Product.search(@query).sorted_by(@sort).includes(:reviews)
  end
end