# frozen_string_literal: false

# Create review service
class Reviews::CreateReviewService < ApplicationService
    attr_reader :product, :title, :content, :rating, :user
  
    def initialize(params)
      @product = params[:product]
      @title = params[:title]
      @content = params[:content]
      @rating = params[:rating]
      @user = params[:user]
    end
  
    def call
      review = Review.new(title: title, content: content, rating: rating)
      review.product = product
      review.user = user
      review
    end
  end