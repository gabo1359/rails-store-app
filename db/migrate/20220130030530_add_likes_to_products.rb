class AddLikesToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :likes, :integer, default: 0
  end
end
