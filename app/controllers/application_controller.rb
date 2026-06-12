class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin?
  before_action :ensure_cart

  private

  # cart is available on every page
  def ensure_cart
    # find the cart by the session
    @cart = Cart.find_by(id: session[:cart_id])
    unless @cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    current_user&.admin?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to continue."
    end
  end

  def require_admin
    unless admin?
      redirect_to root_path, alert: "Admins only."
    end
  end
end
