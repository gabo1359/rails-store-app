class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }

  validates :sku, presence: true, format: { with: /\b\d{4}-\D{3}\b/, message: "format 1234-ABC" }, 
    uniqueness: true     
  validates :name, presence: { message: "must be given please" }, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true
  validates :stock, presence: true, numericality: { only_integer: true }, 
    inclusion: { in: (0..100).to_a, message: "%{value} is not a valid stock" }
end
