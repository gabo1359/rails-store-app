module Representer::Order
  class OrderRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :quantity
  end
end