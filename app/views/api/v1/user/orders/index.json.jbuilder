json.array! @orders do |order|
    json.extract! order, :id, :quantity, :product_id
end