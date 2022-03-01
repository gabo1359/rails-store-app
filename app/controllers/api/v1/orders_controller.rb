class Api::V1::OrdersController < Api::V1::BaseController  
  def index
    @orders = policy_scope(Order)
  end
end
