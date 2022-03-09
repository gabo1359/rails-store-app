# frozen_string_literal: false

# Users controller
class Api::V1::Admin::UsersController < Api::V1::BaseController
  before_action :set_user, only: %i[show destroy]

  def create
    @user = UserForm.new(user_params).submit
    authorize @user
    render :show
  end

  def show; end

  def destroy
    if @user.discarded?
      @user.destroy
    else
      @user.discard
      render :show
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
end
