# frozen_string_literal: false

# Product form
class UserForm
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :address, :phone, :email, :password, :password_confirmation

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: /\w+@\w+\.\w+/ }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, length: { minimum: 6 }

  def initialize(params = {})
    @first_name = params.fetch(:first_name, '')
    @last_name = params.fetch(:last_name, '')
    @address = params.fetch(:address, '')
    @phone = params.fetch(:phone, '')
    @email = params.fetch(:email, '')
    @password = params.fetch(:password, '')
    @password_confirmation = params.fetch(:password_confirmation, '')
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'User')
  end

  def submit
    return false unless valid?

    User.create(first_name: first_name, last_name: last_name, address: address, phone: phone,
                email: email, password: password, password_confirmation: password_confirmation)
    true
  end
end
