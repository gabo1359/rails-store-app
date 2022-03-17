class Payments::CreateStripeCheckoutService < ApplicationService
  attr_reader :product, :order

  def initialize(params)
    @product = params[:product]
    @order = params[:order]
  end

  def call
    session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: product.name,
          images: [product.photo.url],
          amount: (product.price * 100).to_i,
          currency: 'usd',
          quantity: order.quantity
        }],
        success_url: "http://localhost:3000/orders/#{order.id}",
        cancel_url: "http://localhost:3000/products/#{product.id}"
      )
    session
  end
end