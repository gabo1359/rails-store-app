class Form::UserForm < Reform::Form
  feature Reform::Form::Dry

  property :first_name
  property :last_name
  property :address
  property :phone
  property :email
  property :password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: /\w+@\w+\.\w+/ }
  validates :password, presence: true,  length: { minimum: 6 }
end