# Preview all emails at http://localhost:3000/rails/mailers/notify_mailer
class NotifyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_mailer/notify
  def notify
    user = User.last
    product = Product.last
    NotifyMailer.notify(user, product)
  end

end
