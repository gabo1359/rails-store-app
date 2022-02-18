# frozen_string_literal: false

# Product form
# class ProductForm
#   include ActiveModel::Model

#   attr_accessor :sku, :name, :description, :price, :stock, :tag_list

#   validates :sku, presence: true, format: { with: /\b\d{4}-\D{3}\b/, message: 'format 1234-ABC' }
#   validates :name, presence: { message: 'must be given please' }, length: { minimum: 3 }
#   validates :description, presence: true
#   validates :price, presence: true
#   validates :stock, presence: true, numericality: { only_integer: true },
#                     inclusion: { in: (0..100).to_a, message: '%<value>s is not a valid stock' }
#   validates :tag_list, presence: true

#   private

#   def product
#     @product ||= Product.new(sku: sku)
#   end
# end
