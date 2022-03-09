# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/reset_password
  def reset_password
    user = User.last
    UserMailer.reset_password(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/successful_password_change
  def successful_password_change
    user = User.last
    UserMailer.successful_password_change(user)
  end
end
