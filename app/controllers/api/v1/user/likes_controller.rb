class Api::V1::User::LikesController < Api::V1::BaseController
  before_action :find_product
  before_action :find_like, only: [:destroy]

  def create
    @like = Likes::CreateLikeService.call(product: @product, user: current_user)
    authorize @like
  end

  def destroy
    authorize @like
    Likes::DestroyLikeService.call(product: @product, like: @like, user: current_user)
    head :no_content
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_like
    @like = Like.where(user_id: @current_user.id, product_id: @product.id).first
  end

  def render_error
    render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
  end
end
