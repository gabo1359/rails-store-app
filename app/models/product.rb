# frozen_string_literal: false

# Product class
class Product < ApplicationRecord
  include Discard::Model

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :photo

  def stock_less_than_3?
    self.stock <= 3
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).products.where(discarded_at: nil)
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count')
       .joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.sort_products_by(query)
    filter, type = query.split('-')
    case filter
    when 'Name'
      type == 'ascending' ? Product.order('name ASC') : Product.order('name DESC')
    when 'Price'
      type == 'ascending' ? Product.order('price ASC') : Product.order('price DESC')
    else
      Product.order('likes_number DESC')
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
                  against: %i[name description],
                  using: {
                    tsearch: { prefix: true }
                  }
end
