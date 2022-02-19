# frozen_string_literal: false

# Destroy like service
class Likes::DestroyLikeService < ApplicationService
  attr_reader :product, :like, :user

  def initialize(params)
    @product = params[:product]
    @like = params[:like]
    @user = params[:user]
  end

  def call
    if already_liked?
      like.destroy
    else
      flash[:notice] = 'Cannot unlike'
    end
    likes_number = product.likes.count
    product.update(likes_number: likes_number)
  end

  private

  def already_liked?
    query = Likes::GetLikeQuery.call(user: user, product: product)
    query.exists?
  end
end
  