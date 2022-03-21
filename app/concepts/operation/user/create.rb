module Operation::User
  class Create < Trailblazer::Operation
   
    step :extract_params, fail_fast: true
    step :validate_for_create?
    fail :add_errors
    step :create_model
    step :representer
       
    def extract_params(ctx, params:, **)
      user_params = params[:user]
      ctx[:params] = user_params
    end

    def validate_for_create?(ctx, params:, errors:, **)
      model = Form::UserForm.new(User.new)
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
      ctx[:model] = Representer::User::UserRepresenter.new(model.model)
    end
  end    
end