# frozen_string_literal: false

# Get products query
class Products::GetProductsQuery < ApplicationQuery
  attr_reader :tag, :filter, :query, :page, :products_per_page

  def initialize(params)
    @products_per_page = params[:products_per_page]
    @page = params.fetch(:page, 1).to_i
    @tag = params[:tag]
    @filter = params[:filter]
    @query = params[:query]
  end

  def call
    products = tag.present? ? Product.tagged_with(tag) : Product.kept
    products = filter.present? ? products.sort_products_by(filter) : products.order(created_at: :desc)
    products = products.search_by_name_and_description(query) if query.present?
    products
  end
end
