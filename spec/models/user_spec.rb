# frozen_string_literal: false

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user model validation' do
    it 'must have an email' do
      user = build(:user, email: '').save
      expect(user).to eq(false)
    end

    it 'must have a password' do
      user = build(:user, password: '').save
      expect(user).to eq(false)
    end

    it 'email must be unique' do
      build(:user).save
      user2 = build(:user).save
      expect(user2).to eq(false)
    end
  end
end
