class Form::ProductForm < Reform::Form
  feature Reform::Form::Dry

  property :sku
  property :name
  property :description
  property :price
  property :stock

  validates :sku, presence: true, format: { with: /\b\d{4}-\D{3}\b/, message: 'format 1234-ABC' }
  validates :name, presence: { message: 'must be given please' }, length: { minimum: 3 }
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true, numericality: { only_integer: true }
end