require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user model validation' do
    it 'must have an email' do
      user = User.new(password: 'password').save
      expect(user).to eq(false)
    end

    it 'must have a password' do
      user = User.new(email: 'email@applaudo.com').save
      expect(user).to eq(false)
    end

    it 'email must be unique' do
      User.new(email: 'example', password: 'password').save
      user2 = User.new(email: 'example', password: 'password').save
      expect(user2).to eq(false)
    end
  end
end
