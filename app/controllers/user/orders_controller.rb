# frozen_string_literal: false

# Orders controller
class User::OrdersController < ApplicationController
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

    # session = Stripe::Checkout::Session.create(
    #     payment_method_types: ['card'],
    #     line_items: [{
    #       name: teddy.sku,
    #       images: [teddy.photo_url],
    #       amount: teddy.price_cents,
    #       currency: 'eur',
    #       quantity: 1
    #     }],
    #     success_url: order_url(order),
    #     cancel_url: order_url(order)
    #   )

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
