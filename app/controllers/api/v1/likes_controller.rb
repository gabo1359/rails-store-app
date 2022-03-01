class Api::V1::LikesController < Api::V1::BaseController
  before_action :find_product
  before_action :find_like, only: [:destroy]

  def create
    @like = Like.new(product_id: @product.id, user_id: @current_user.id) 
    authorize @like
    if @like.save
      likes_number = @product.likes.count
      @product.update(likes_number: likes_number)
    else
      render_error
    end
  end

  def destroy
    @like.destroy
    authorize @like
    likes_number = @product.likes.count
    @product.update(likes_number: likes_number)
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
