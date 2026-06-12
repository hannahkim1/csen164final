class ProductsController < ApplicationController
  before_action :require_admin, only: %i[ new create edit update destroy ]
  before_action :set_product, only: %i[ show edit update destroy ]

  # get the products
  def index
    @products = Product.all
  end

  # get product/1
  def show
    @reviews = @product.reviews.includes(:user).order(created_at: :desc)
    @user_review = current_user && @product.reviews.find_by(user: current_user)
    @new_review = Review.new
  end

  # new product
  def new
    @product = Product.new
  end

  # edit product/1
  def edit
  end

  # create a new product
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # update product/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # delete product/1
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # set the product
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # set the product parameters
    def product_params
      params.expect(product: [ :name, :description, :image, :price ])
    end
end
