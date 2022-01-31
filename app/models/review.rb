class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, presence: { message: "must be given please" }
end
