# frozen_string_literal: false

# Products controller
class Users::ProductsController < ApplicationController
  
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  PRODUCTS_PER_PAGE = 8.0

  def index
    @page = params.fetch(:page, 1).to_i
    @total_pages = (Product.count / PRODUCTS_PER_PAGE).ceil
    @tags = %w[Beverages Cereals Dairy Fats Nuts Seeds Sauces Soups Snacks Desserts Miscellaneous]
    @sorts = %w[Name-ascending Name-descending Price-ascending Price-descending Most-liked]
    @pagy, @products = pagy(Products::GetProductsService.call(params), items: PRODUCTS_PER_PAGE)
  end

  def show
    @review = Review.new
    @order = Order.new
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:sku, :name, :description, :price, :stock,
                                    :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end
