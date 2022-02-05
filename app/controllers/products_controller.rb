class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:query].present?
      @products = Product.search_by_name_and_description(params[:query])
    elsif params[:tag]
      @products = Product.tagged_with(params[:tag])
    else
      @products = Product.where('stock > ?', 0).order('created_at DESC')
    end
    @tags = %w[ Beverages Cereals Dairy Fats Nuts Seeds Sauces Soups Snacks Desserts Miscellaneous ]
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
    params.require(:product).permit(:sku, :name, :description, :price, :stock, :tag_list)
  end
end
