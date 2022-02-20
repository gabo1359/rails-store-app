class Likes::GetLikeQuery < ApplicationQuery
  attr_accessor :user, :product
  
  def initialize(params)
    @user = params[:user]
    @product = params[:product]
  end

  def call
    Like.where(user_id: user.id, product_id: product)
  end
end