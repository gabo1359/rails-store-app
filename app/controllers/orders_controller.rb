class OrdersController < ApplicationController
    before_action :set_order, only: %i[show destroy]

  def index
    @orders = Order.all
    @total_amount = 0
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.product = @product
    @order.user = current_user
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
