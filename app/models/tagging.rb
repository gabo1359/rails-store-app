# frozen_string_literal: false

class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :product
end
