class Api::V1::User::OrdersController < Api::V1::BaseController  
  def index
    @orders = policy_scope(Order)
  end

  def create
    @order = Orders::CreateOrderService.call(product_id: params[:product_id],
                                             quantity: order_params[:quantity],
                                             user: current_user)
    @order.save
    authorize @order
    render :show
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end
end
