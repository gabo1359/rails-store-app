# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    email { 'example@applaudo.com' }
    password { 'password' }
    admin { false }
  end
end
