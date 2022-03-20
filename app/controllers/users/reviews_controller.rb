# frozen_string_literal: false

# Reviews controller
class Users::ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = Reviews::CreateReviewService.call(product: @product,
                                                title: review_params[:title],
                                                content: review_params[:content],
                                                rating: review_params[:rating],
                                                user: current_user)
    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
