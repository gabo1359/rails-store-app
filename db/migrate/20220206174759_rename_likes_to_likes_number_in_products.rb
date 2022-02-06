class RenameLikesToLikesNumberInProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :likes, :likes_number
  end
end
