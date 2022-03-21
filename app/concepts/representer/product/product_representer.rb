module Representer::Product
  class ProductRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :sku
    property :name
    property :description
    property :price
    property :stock
  end
end