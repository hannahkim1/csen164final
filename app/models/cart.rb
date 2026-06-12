class Cart < ApplicationRecord
    has_many :cartitems, dependent: :destroy

    def add_cartitem(product_id)
        current_item = self.cartitems.find_by(product_id: product_id)
        
        if current_item
            # .to_i converts nil to 0, ensuring the math works
            current_item.quantity = current_item.quantity.to_i + 1
        else
            # Explicitly set the starting quantity to 1 for new items
            current_item = self.cartitems.build(product_id: product_id, quantity: 1)
        end
        
        current_item
    end

    def total_price
        self.cartitems.to_a.sum do |item|
            item.item_total_price
        end
    end
end




