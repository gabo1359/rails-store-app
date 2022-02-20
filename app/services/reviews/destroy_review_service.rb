# frozen_string_literal: false

# Destroy review service
class Reviews::DestroyReviewService < ApplicationService
  attr_reader :review_id
  
  def initialize(params)
    @review_id = params[:review_id]
  end

  def call
    review = Review.find(review_id)
    review.destroy
  end
end
