# frozen_string_literal: false

# Product form
class ProductForm
  include ActiveModel::Model

  attr_accessor :sku, :name, :description, :price, :stock, :tag_list, :tag_ids, :product, :photo

  validates :sku, presence: true, format: { with: /\b\d{4}-\D{3}\b/, message: 'format 1234-ABC' }
  validates :name, presence: { message: 'must be given please' }, length: { minimum: 3 }
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true, numericality: { only_integer: true }
  validates :tag_ids, presence: true

  def submit
    return false unless valid?

    Product.create(sku: sku, name: name, description: description, price:  price, stock: stock,
                   tag_ids: tag_ids, photo: photo)
    true
  end

  def update?
    return false unless valid?
    product.update(sku: sku, name: name, description: description, price:  price, stock: stock,
                   tag_ids: tag_ids, photo: photo)
    true
  end
end
