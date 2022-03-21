module Operation::Product
  class Index < Trailblazer::Operation
    step :model!

    def model!(ctx, params:, **)
        ctx[:model] = Representer::Product::ProductRepresenter.for_collection.new(Product.all)
    end
  end
end
