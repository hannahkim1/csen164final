class OrdersController < ApplicationController
  include CurrentCart

  before_action :require_login
  before_action :set_cart, only: %i[ new create ]

  def index
    # if its the admin account then show all the orders
    scope = admin? ? Order.all : current_user.orders
    # but if not then just show the orders of the user logged in
    @orders = scope.includes(:user).order(created_at: :desc)
  end

  def show
    scope = admin? ? Order.all : current_user.orders
    @order = scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: "You can only view your own orders."
  end

  def new
    # if the cart is empty then redirect to root
    if @cart.cartitems.empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.add_cartitems_from_cart(@cart)

    # if the order is saved then redirect to the order page
    if @order.save
      @cart.reload.destroy
      session.delete(:cart_id)
      redirect_to @order, notice: "Thank you for your order!"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def order_params
    params.expect(order: [ :name, :email, :pay_type ])
  end
end
