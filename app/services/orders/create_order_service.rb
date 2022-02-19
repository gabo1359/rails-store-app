# frozen_string_literal: false

# Create order service
class Orders::CreateOrderService < ApplicationService
  attr_reader :product_id, :quantity, :user

  def initialize(params)
    @product_id = params[:product_id]
    @quantity = params[:quantity]
    @user = params[:user]
  end

  def call
    product = Product.find(product_id)
    order = Order.new(quantity: quantity)
    order.product = product
    order.user = user.nil? ? User.find(2) : user
    product.stock -= order.quantity
    product.save
    order
  end
end
