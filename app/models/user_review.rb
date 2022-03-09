class UserReview < ApplicationRecord
  belongs_to :for_user, foreign_key: 'for_user', class_name: 'User'
  belongs_to :by_user, foreign_key: 'by_user', class_name: 'User'

  scope :reviews_for, ->(user) { where("for_user = ?", user) }
  scope :reviews_by,  ->(user) { where("by_user = ?", user) }
end
