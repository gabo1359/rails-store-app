# frozen_string_literal: false

# Users controller
class Api::V1::User::UserReviewsController < Api::V1::BaseController
  before_action :set_user_review, only: %i[show update]

  def create
    @user_review = UserReviews::CreateUserReviewService.call(user_review_params.merge({ by_user: current_user.id }))
    authorize @user_review
    if @user_review.save
      render :show
    end
  end

  def show; end

  def update
    if @user_review.update(user_review_params)
      render :show
    end
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