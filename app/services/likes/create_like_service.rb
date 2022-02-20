# frozen_string_literal: false

# Create like service
class Likes::CreateLikeService < Likes::ApplicationLikeService
  attr_reader :product, :user

  def initialize(params)
    @product = params[:product]
    @user = params[:user]
  end

  def call
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      product.likes.create(user_id: user.id)
    end
    likes_number = product.likes.count
    product.update(likes_number: likes_number)
  end
end
