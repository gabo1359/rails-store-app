# frozen_string_literal: false

# Orders controller
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show destroy]
  skip_before_action :authenticate_user!, only: %i[index create destroy]

  def index
    if user_signed_in? && current_user.admin
      @orders = Order.all
    elsif !user_signed_in?
      user_id = User.find(2).id
      @orders = Order.where(user_id: user_id)
    else
      @orders = Order.where(user_id: current_user.id)
    end
    @total_amount = 0
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.product = @product
    user_signed_in? ? @order.user = current_user : @order.user = User.find(2)
    @product.stock -= @order.quantity
    @product.save
    if @order.save
      redirect_to orders_path
    else
      render 'products/show'
    end
  end

  def destroy
    @order = Order.find(params[:order_id])
    @order.destroy
    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:quantity)
  end
end
