class Api::V1::ProductsController < Api::V1::BaseController
  def index
    @products = policy_scope(Product)
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end
end
