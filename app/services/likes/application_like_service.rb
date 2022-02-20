# frozen_string_literal: false

# Application like service
class Likes::ApplicationLikeService < ApplicationService
  protected

  def already_liked?
    query = Likes::GetLikeQuery.call(user: user, product: product)
    query.exists?
  end
end
