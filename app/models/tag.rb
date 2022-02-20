# frozen_string_literal: false

class Tag < ApplicationRecord
  has_many :taggings
  has_many :products, through: :taggings
end
