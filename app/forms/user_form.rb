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
  validates :password, presence: true,  length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  validate :validate_password

  def self.model_name
    ActiveModel::Name.new(self, nil, 'User')
  end

  def submit
    return false unless valid?
    User.create({first_name: first_name, last_name: last_name, address: address, phone: phone,
              email: email, password: password, password_confirmation: password_confirmation})
  end

  private
  
  def validate_password
    return if password == password_confirmation 

    errors.add(:password_confirmation, 'is different of password')
  end
end