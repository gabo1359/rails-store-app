module Operation::Order
  class Show < Trailblazer::Operation
    step :model!

    def model!(ctx, params:, **)
        ctx[:model] = Representer::Order::OrderRepresenter.new(Order.find_by(id: params[:id]))
    end
  end
end
