class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, presence: { message: "must be given please" }
  validates :rating, numericality: { only_integer: true }, :inclusion => 1..5

  def blank_stars
    5 - rating
  end
end
