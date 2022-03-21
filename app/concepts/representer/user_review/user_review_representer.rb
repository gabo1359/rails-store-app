module Representer::UserReview
  class UserReviewRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :title
    property :content
    property :approved
  end
end
