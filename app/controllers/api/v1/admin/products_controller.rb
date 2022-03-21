class Api::V1::Admin::ProductsController < Api::V1::BaseController
  include Pagy::Backend

  before_action :ensure_admin!
  before_action :set_product, only: [:show, :update, :destroy]

  def create
    # p product_params.to_hash
    result = Operation::Product::Create.call(params: product_params.to_hash, errors: {})
# p result
    # render json: { data: { product: result[:model].to_json } }
  end

  def show; end

  def update
    if @product.update(product_params)
      render :show
    end
  end

  def destroy
    if @product.discarded?
      @product.destroy
    else
      @product.discard
      render :show
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:sku, :name, :description, :price, :stock,
                                    :tag_list, :tag, { tag_ids: [] }, :tag_ids, :photo)
  end

  def ensure_admin!
    unless current_user.admin
      raise CustomError.new('Authorization error', :unauthorized, "You're not an admin")
    end
  end
end
