
class Api::V1::AuthenticationController < Api::V1::BaseController
  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def api_login_controller?
    true
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
