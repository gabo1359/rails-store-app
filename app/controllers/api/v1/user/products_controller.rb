class Api::V1::User::ProductsController < Api::V1::BaseController
  include Pagy::Backend

  before_action :set_product, only: :show
  
  def index
    @products = policy_scope(Products::GetProductsQuery.call(params))
    
    # Using representers
    # products = policy_scope(Products::GetProductsQuery.call(params))
    # render json: ProductsRepresenter.new(products).as_json
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:sku, :name, :description, :price, :stock,
                                    :tag_list, :tag, { tag_ids: [] }, :tag_ids, :photo)
  end

  def render_error
    render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
  end
end
