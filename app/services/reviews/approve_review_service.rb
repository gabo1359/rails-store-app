# frozen_string_literal: false

# Approve review service
class Reviews::ApproveReviewService < ApplicationService
  attr_reader :review_id

  def initialize(params)
    @review_id = params[:review_id]
  end

  def call
    review = Review.find(review_id)
    review.update(approved: true)
    review
  end
end
