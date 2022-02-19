# frozen_string_literal: false

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
