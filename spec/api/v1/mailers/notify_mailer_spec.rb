# frozen_string_literal: false

require 'rails_helper'

RSpec.describe NotifyMailer, type: :mailer do
  describe 'mail information' do
    let(:user) { User.create(first_name: 'Jose', last_name: "Perez", email: 'example@applaudo.com') }
    let(:mail) { NotifyMailer.notify(user, create(:product)) }

    it 'renders the subject' do
      expect(mail.subject).to eql('This is your last chance to buy it!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['gabodck@gmail.com'])
    end
  end
end
