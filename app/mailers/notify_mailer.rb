class NotifyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_mailer.notify.subject
  #
  def notify(user, product)
    @user = user
    @product = product
    mail to: user.email, subject: 'This is your last chance to buy it!'
  end
end
