# frozen_string_literal: false

# Users controller
class Support::UsersController < ApplicationController

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

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :phone, :address,
                                 :password_confirmation)
  end
end
