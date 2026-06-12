module CurrentCart
    extend ActiveSupport::Concern
    
    def set_cart    
        # Change @carttem to @cart
        @cart = Cart.find(session[:cart_id]) 
    rescue ActiveRecord::RecordNotFound
        # Change @carttem to @cart
        @cart = Cart.create
        session[:cart_id] = @cart.id
    end
end