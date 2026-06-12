class AllowNullCartIdOnCartitems < ActiveRecord::Migration[8.1]
  def change
    change_column_null :cartitems, :cart_id, true
  end
end
