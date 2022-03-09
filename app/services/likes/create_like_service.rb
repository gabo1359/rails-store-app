# frozen_string_literal: false

# Create like service
class Likes::CreateLikeService < Likes::ApplicationLikeService
  attr_reader :product, :user

  def initialize(params)
    @product = params[:product]
    @user = params[:user]
  end

  def call
    if !already_liked?(user, product)
      like = product.likes.create(user_id: user.id)
      likes_number = product.likes.count
      product.update(likes_number: likes_number)
      like
    end
  end
end
