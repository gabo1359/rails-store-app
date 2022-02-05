class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).products
  end
  
  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

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
  validates :tag_list, presence: true
end
