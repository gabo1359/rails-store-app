class ResetPasswordJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    # Do something later
    puts 'Sending email'
    UserMailer.reset_password(user).deliver_now
    puts 'Done'
  end
end
