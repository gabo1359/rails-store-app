class AddUserIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user
  end
end
