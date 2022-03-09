# frozen_string_literal: false

# Users controller
class Api::V1::Admin::UsersController < Api::V1::BaseController
  before_action :set_user, only: %i[show destroy]

  def new
    @user_form = User.new
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      render :show
    else
      render_error
    end
  end

  def show; end

  def destroy
    if @user.discarded?
      @user.destroy
    else
      @user.discard
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :phone, :address,
                                 :password_confirmation, :admin, :support)
  end

  def render_error
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
end
