# frozen_string_literal: false

# Orders controller
class OrdersController < ApplicationController
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
    @order = Orders::CreateOrderService.call(product: @product, 
                                             quantity: order_params[:quantity],
                                             user: current_user)
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

  def order_params
    params.require(:order).permit(:quantity)
  end
end
