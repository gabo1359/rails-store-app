# frozen_string_literal: false

# Reviews controller
class Admin::ReviewsController < ApplicationController
  # def create
  #   @product = Product.find(params[:product_id])
  #   @review = Reviews::CreateReviewService.call(product: @product,
  #                                               title: review_params[:title],
  #                                               content: review_params[:content],
  #                                               rating: review_params[:rating],
  #                                               user: current_user)
  #   if @review.save
  #     redirect_to product_path(@product)
  #   else
  #     render 'products/show'
  #   end
  # end

  def update
    if params[:change] == 'true'
      @review = Reviews::ApproveReviewService.call(review_id: params[:id])
    else
      @review = Reviews::DisapproveReviewService.call(review_id: params[:id])
    end
    @product = @review.product
    redirect_to product_path(@product)
  end

  def destroy
    Reviews::DestroyReviewService.call(review_id: params[:id])
    redirect_to product_path(params[:product_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
