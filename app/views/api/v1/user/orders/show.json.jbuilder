json.extract! @order, :id, :quantity

json.product do
    json.name @order.product.name
    json.price @order.product.price
end
