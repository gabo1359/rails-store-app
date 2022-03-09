class CreateUserReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :user_reviews do |t|
      t.string :title
      t.string :content
      t.integer :for_user
      t.integer :by_user

      t.timestamps
    end
  end
end
