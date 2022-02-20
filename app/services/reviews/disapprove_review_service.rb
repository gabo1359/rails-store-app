# frozen_string_literal: false

# Disapprove review service
class Reviews::DisapproveReviewService < ApplicationService
  attr_reader :review_id

  def initialize(params)
    @review_id = params[:review_id]
  end

  def call
    review = Review.find(review_id)
    review.update(approved: false)
    review
  end
end
