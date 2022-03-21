module Operation::Product
  class Show < Trailblazer::Operation
    step :model!

    def model!(ctx, params:, **)
        ctx[:model] = Representer::Product::ProductRepresenter.new(Product.find_by(id: params[:id]))
    end
  end
end
