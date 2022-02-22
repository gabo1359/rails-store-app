# frozen_string_literal: false

# Products controller
class User::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @tags = %w[Beverages Cereals Dairy Fats Nuts Seeds Sauces Soups Snacks Desserts Miscellaneous]
    @filters = %w[Name-ascending Name-descending Price-ascending Price-descending Most-liked]
    @products = Products::GetProductsService.call(params)
  end

  def show
    @review = Review.new
    @order = Order.new
  end

  # def new
  #   @product_form = Product.new
  # end

  # def create
  #   @product_form = ProductForm.new(product_params)
  #   if @product_form.submit
  #     redirect_to products_path
  #   else
  #     render :new
  #   end
  # end

  # def edit; end

  # def update
  #   if @product.update(product_params)
  #     redirect_to product_path(@product)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @product.destroy
  #   redirect_to products_path
  # end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:sku, :name, :description, :price, :stock,
                                    :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end
