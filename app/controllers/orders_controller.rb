# frozen_string_literal: false

# Orders controller
class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index create destroy]

  def index
    @total_amount = 0
    return @orders = Order.all if user_signed_in? && current_user.admin
    return @orders = Order.where(user_id: User.find(2).id) if !user_signed_in?
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @order = Orders::CreateOrderService.call(product_id: params[:product_id],
                                             quantity: order_params[:quantity],
                                             user: current_user)
    if @order.save
      redirect_to orders_path
    else
      render 'products/show'
    end
  end

  def destroy
    Orders::DestroyOrderService.call(order_id: params[:order_id])
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end
end
