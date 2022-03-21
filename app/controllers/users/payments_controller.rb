class Users::PaymentsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    if current_user == nil
      @order = User.find(2).orders.where(state: 'pending').find(params[:order_id])
    else
      @order = current_user.orders.where(state: 'pending').find(params[:order_id])
    end
  end
end
