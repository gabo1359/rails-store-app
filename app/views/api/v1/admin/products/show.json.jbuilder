json.extract! @product, :id, :sku, :name, :description, :price, :stock, :likes_number, :tag_list

json.image @product.photo.url ? @product.photo.url : 'http://localhost:3000/assets/coca_cola.png'

json.discard do
  json.state @product.discarded_at ? true : false
end

json.reviews @product.reviews do |review|
    json.extract! review, :id, :title, :content, :rating, :approved
    json.user do
        json.id review.user.id
        json.email review.user.email
    end
end
