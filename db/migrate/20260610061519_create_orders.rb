class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :pay_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
