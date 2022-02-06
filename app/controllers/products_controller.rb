# frozen_string_literal: false

# Products controller
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @tags = %w[Beverages Cereals Dairy Fats Nuts Seeds Sauces Soups Snacks Desserts Miscellaneous]
    @filters = %w[Name-ascending Name-descending Price-ascending Price-descending Most-liked]
    return @products = Product.search_by_name_and_description(params[:query]) if params[:query].present?

    return @products = Product.tagged_with(params[:tag]) if params[:tag]

    return @products = Product.sort_products_by(params[:filter]) if params[:filter]

    @products = Product.where('stock > ?', 0).order('created_at DESC')
  end

  def show
    @review = Review.new
    @order = Order.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
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
