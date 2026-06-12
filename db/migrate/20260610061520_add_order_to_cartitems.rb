class AddOrderToCartitems < ActiveRecord::Migration[8.1]
  def change
    add_reference :cartitems, :order, null: true, foreign_key: true
  end
end
