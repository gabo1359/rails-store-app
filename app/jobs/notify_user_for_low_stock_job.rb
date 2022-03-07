class NotifyUserForLowStockJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find(product_id)
    user = product.likes.last.user
    NotifyMailer.notify(user, product).deliver_later
  end
end
