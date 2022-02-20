# frozen_string_literal: false

class Like < ApplicationRecord
  belongs_to :product
  belongs_to :user
end
