# frozen_string_literal: false

# Likes controller
class User::LikesController < ApplicationController
  before_action :find_product
  before_action :find_like, only: [:destroy]

  def create
    Likes::CreateLikeService.call(product: @product, user: current_user)
    redirect_to product_path(@product)
  end

  def destroy
    Likes::DestroyLikeService.call(product: @product, like: @like, user: current_user)
    redirect_to product_path(@product)
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_like
    @like = @product.likes.find(params[:id])
  end
end
