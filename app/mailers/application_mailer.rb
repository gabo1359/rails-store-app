# frozen_string_literal: false

class ApplicationMailer < ActionMailer::Base
  default from: 'gabodck@gmail.com'
  layout 'mailer'
end
