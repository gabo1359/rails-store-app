# frozen_string_literal: false

# Users controller
class Api::V1::Support::UsersController < Api::V1::BaseController
  before_action :ensure_support!
  before_action :set_user, only: :show

  def create
    @user = UserForm.new(user_params).submit
    authorize @user
    render :show
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :phone, :address,
                                 :password_confirmation, :admin, :support)
  end

  def ensure_support!
    unless current_user.support
      raise CustomError.new('Authorization error', :unauthorized, "You don't have a support role")
    end
  end
end
