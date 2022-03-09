# frozen_string_literal: false

# Product form
class UserForm
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :address, :phone, :email, :password, :password_confirmation, :admin, :support

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
    unless valid?
      raise CustomError.new('Validation error', :unprocessable_entity, "Wrong argument")
    end
    
    User.create({first_name: first_name, last_name: last_name, address: address, phone: phone,
              email: email, password: password, password_confirmation: password_confirmation,
              admin: admin, support: support})
  end

  private
  
  def validate_password
    return if password == password_confirmation 

    errors.add(:password_confirmation, 'is different of password')
  end
end
