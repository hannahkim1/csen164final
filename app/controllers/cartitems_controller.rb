class CartitemsController < ApplicationController

  include CurrentCart 
  # call set_cart method
  before_action :set_cart 

  before_action :set_cartitem, only: %i[ show edit update destroy ]

  # get all the cartitems
  def index
    @cartitems = Cartitem.all
  end

  # get cartitem/1
  def show
  end

  # new cartitem
  def new
    @cartitem = Cartitem.new
  end

  # edit cartitem/1
  def edit
  end

  # create a new cartitem
  def create
    product_id = params[:product_id]
    product_obj = Product.find(product_id)
    cart_obj = @cart 

    @cartitem = @cart.add_cartitem product_obj.id

    #redirect to id
    respond_to do |format|
      if @cartitem.save
        format.html { redirect_back fallback_location: root_path, notice: "Added to cart." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @cartitem.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @cartitem.update(cartitem_params)
        format.html { redirect_to @cartitem, notice: "Cartitem was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @cartitem }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @cartitem.errors, status: :unprocessable_content }
      end
    end
  end

  # delete cartitem/1
  def destroy
    @cartitem.destroy!

    respond_to do |format|
      format.html { redirect_to cartitems_path, notice: "Cartitem was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_cartitem
      @cartitem = Cartitem.find(params.expect(:id))
    end

    #expect the cartitem parameters
    def cartitem_params
      params.expect(cartitem: [ :cart_id, :product_id ])
    end
end
