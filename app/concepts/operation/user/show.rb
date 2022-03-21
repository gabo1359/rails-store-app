module Operation::User
  class Show < Trailblazer::Operation
    step :model!

    def model!(ctx, params:, **)
        ctx[:model] = Representer::User::UserRepresenter.new(User.find_by(id: params[:id]))
    end
  end
end
