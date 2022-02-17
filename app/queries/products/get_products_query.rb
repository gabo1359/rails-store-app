class GetProductsQuery < ApplicationQuery
  attr_reader :params
  
  def initialize(params)
    @params = params
  end

  def call
    products = @params[:tag].present? ? Product.tagged_with(@params[:tag]) : Product.all
    products = @params[:filter].present? ? products.sort_products_by(@params[:filter]) : products.order(created_at: :desc)
    products = products.search_by_name_and_description(@params[:query]) if @params[:query].present?
    products
  end
end