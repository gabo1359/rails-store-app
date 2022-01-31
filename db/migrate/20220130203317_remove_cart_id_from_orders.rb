class RemoveCartIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :cart_id
  end
end
