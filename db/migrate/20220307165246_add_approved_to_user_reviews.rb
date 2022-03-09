class AddApprovedToUserReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :user_reviews, :approved, :boolean, default: false
  end
end
