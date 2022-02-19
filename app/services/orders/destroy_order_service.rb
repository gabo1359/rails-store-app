# frozen_string_literal: false

# Destroy order service
class Orders::DestroyOrderService < ApplicationService
    attr_reader :order_id
  
    def initialize(params)
      @order_id = params[:order_id]
    end
  
    def call
      order = Order.find(order_id)
      order.destroy
    end
  end
