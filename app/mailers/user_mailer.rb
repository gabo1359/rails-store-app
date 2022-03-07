class UserMailer < Devise::Mailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset.subject
  #

  include Devise::Controllers::UrlHelpers
  default template_path: 'user_mailer'

  def reset_password(user)
    create_reset_password_token(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end

  def successful_password_change(user)
    @user = user
    mail to: user.email, subject: 'Your password was changed successfully'
  end

  private

  def create_reset_password_token(user)
      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      @token = raw
      user.reset_password_token = hashed
      user.reset_password_sent_at = Time.now.utc
      user.save
  end
end
