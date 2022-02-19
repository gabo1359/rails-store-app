class Orders::CreateOrderService < ApplicationService
  attr_reader :product, :quantity, :user

  def initialize(params)
    @product = params[:product]
    @quantity = params[:quantity]
    @user = params[:user]
  end

  def call
    order = Order.new(quantity: quantity)
    order.product = product
    user.nil? ? order.user = User.find(2): order.user = user
    product.stock -= order.quantity
    product.save
    order
  end
end