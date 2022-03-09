# frozen_string_literal: false

# Users controller
class Api::V1::Admin::UserReviewsController < Api::V1::BaseController
  before_action :set_user_review, only: %i[show update destroy]

  def show; end

  def update
    if @user_review.update(user_review_params)
      render :show
    end
  end

  def destroy
    @user_review.destroy
  end

  private

  def set_user_review
    @user_review = UserReview.find(params[:id])
    authorize @user_review
  end

  def user_review_params
    params.require(:user_review).permit(:title, :content, :for_user, :approved)
  end
end
