module Operation::Product
  class Create < Trailblazer::Operation
   
    step :extract_params, fail_fast: true
    step :validate_for_create?
    fail :add_errors
    step :create_model
    step :representer
       
    def extract_params(ctx, params:, **)
      product_params = params[:product]
      ctx[:params] = product_params
    end

    def validate_for_create?(ctx, params:, errors:, **)
      model = Form::ProductForm.new(Product.new)
      ctx[:model] = model
      model.validate(params)
    end

    def add_errors(ctx, model:, errors:, **)
      errors[:type] = model.errors
    end

    def create_model(ctx, model:, **)
      model.save
    end

    def representer(ctx, model:, **)
      ctx[:model] = Representer::Product::ProductRepresenter.new(model.model)
    end
  end    
end