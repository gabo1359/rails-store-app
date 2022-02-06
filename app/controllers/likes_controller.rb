# frozen_string_literal: false

# Likes controller
class LikesController < ApplicationController
  before_action :find_product
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @product.likes.create(user_id: current_user.id)
    end
    likes_number = @product.likes.count
    @product.update(likes_number: likes_number)
    redirect_to product_path(@product)
  end

  def destroy
    if already_liked?
      @like.destroy
    else
      flash[:notice] = 'Cannot unlike'
    end
    likes_number = @product.likes.count
    @product.update(likes_number: likes_number)
    redirect_to product_path(@product)
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, product_id: params[:product_id]).exists?
  end

  def find_like
    @like = @product.likes.find(params[:id])
  end
end
