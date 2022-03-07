# frozen_string_literal: false

# Users controller
class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: %i[show destroy]

  def new
    @user_form = User.new
  end

  def create
    @user_form = UserForm.new(user_params)
    # var = @user_form.submit

    if @user_form.submit
      flash[:notice] = 'The user was created successfully.'
      redirect_to products_path
    else
      render :new
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
                                 :password_confirmation)
  end
end
