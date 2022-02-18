# frozen_string_literal: false

# Get products service
class GetProductsService < ApplicationService
  attr_accessor :params
  
  def initialize(params)
    @params = params
  end

  def call
    get_products(@params)
  end

  private

  def get_products(params)
    GetProductsQuery.call(params)
  end
end
