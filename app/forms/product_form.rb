# frozen_string_literal: false

# Product form
class ProductForm
  include ActiveModel::Model

  attr_accessor :sku, :name, :description, :price, :stock, :tag_list, :tag_ids

  validates :sku, presence: true, format: { with: /\b\d{4}-\D{3}\b/, message: 'format 1234-ABC' }
  validates :name, presence: { message: 'must be given please' }, length: { minimum: 3 }
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true, numericality: { only_integer: true },
                    inclusion: { in: (0..100).to_a, message: '%<value>s is not a valid stock' }
  validates :tag_list, presence: true

  def initialize(params = {})
    @sku = params.fetch(:sku, '')
    @name = params.fetch(:name, '')
    @description = params.fetch(:description, '')
    @price = params.fetch(:price, '')
    @stock = params.fetch(:stock, '')
    @tag_list = params.fetch(:tag_list, '')
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Product')
  end

  def save
    return false unless valid?
    Product.create(sku: sku, name: name, description: description, price:  price, stock: stock,
                   tag_list: tag_list)
    true
  end
end
