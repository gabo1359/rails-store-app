class ProductsRepresenter
  def initialize(products)
    @products = products
  end

  def as_json
    products.map do |product|
      {
        id: product.id,
        sku: product.sku,
        name: product.name,
        description: product.description,
        price: product.price,
        stock: product.stock
      }
    end
  end

  private

  attr_reader :products
end