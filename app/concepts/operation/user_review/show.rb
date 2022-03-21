module Operation::UserReview
  class Show < Trailblazer::Operation
    step :model!

    def model!(ctx, params:, **)
        ctx[:model] = Representer::UserReview::UserReviewRepresenter.new(UserReview.find_by(id: params[:id]))
    end
  end
end
