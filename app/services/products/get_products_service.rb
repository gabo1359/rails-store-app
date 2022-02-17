require_relative '../../queries/products/get_products_query.rb'

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
