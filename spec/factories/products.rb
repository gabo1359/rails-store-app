# frozen_string_literal: false

FactoryBot.define do
  factory :product do
    sku { '1234-ABC' }
    name { 'product' }
    description { 'description' }
    price { 10 }
    stock { 15 }
    tag_list { 'tag' }
  end
end
