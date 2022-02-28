json.extract! @product, :id, :sku, :name, :description, :price, :stock, :likes_number, :tag_list
json.reviews @product.reviews do |review|
    json.extract! review, :id, :title, :content, :rating, :approved
    json.user do
        json.id review.user.id
        json.email review.user.email
    end
end
