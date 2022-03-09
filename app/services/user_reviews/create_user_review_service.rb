# frozen_string_literal: false

# Create review service
class UserReviews::CreateUserReviewService < ApplicationService
    attr_reader :title, :content, :for_user, :by_user
  
    def initialize(params)
      @title = params[:title]
      @content = params[:content]
      @for_user = params[:for_user]
      @by_user = params[:by_user]
    end
  
    def call
      for_user_instance = User.find(for_user)
      by_user_instance = User.find(by_user)
      user_review = UserReview.new(title: title, content: content, 
                                for_user: for_user_instance, by_user: by_user_instance)
      user_review
    end
  end
  