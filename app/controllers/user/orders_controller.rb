# frozen_string_literal: false

# Orders controller
class User::OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show create destroy]

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @total_amount = 0
    return @orders = Order.all if user_signed_in? && current_user.admin
    return @orders = Order.where(user_id: User.find(2).id) if !user_signed_in?
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    product = Product.find(params[:product_id])
    order = Orders::CreateOrderService.call(product_id: product.id,
                                             quantity: order_params[:quantity],
                                             user: current_user)
    
    session = Payments::CreateStripeCheckoutService.call(product: product, order: order)
    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
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
