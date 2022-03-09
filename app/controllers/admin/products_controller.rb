# frozen_string_literal: false

# Products controller
class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def new
    @product_form = Product.new
  end

  def create
    @product_form = ProductForm.new(product_params)
    if @product_form.submit
      redirect_to products_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @product_form = @product
    if @product_form.update?
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    if @product.discarded?
      @product.destroy
    else
      @product.discard
    end
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:sku, :name, :description, :price, :stock,
                                    :tag_list, :tag, { tag_ids: [] }, :tag_ids, :photo)
  end
end
