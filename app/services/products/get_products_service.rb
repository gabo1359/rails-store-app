# frozen_string_literal: false

# Get products service
class Products::GetProductsService < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    get_products(params)
  end

  private

  def get_products(params)
    Products::GetProductsQuery.call(params)
  end
end
