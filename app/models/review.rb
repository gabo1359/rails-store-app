# frozen_string_literal: false

# Review class
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, presence: { message: 'must be given please' }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: 1..5

  def blank_stars
    5 - rating
  end

  def date_and_time
    created_at.utc.localtime('-05:00').strftime('%h %d, %Y - %I:%M %p')
  end
end
