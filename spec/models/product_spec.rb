# frozen_string_literal: false

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'product model validation' do
    it 'must have a SKU' do
      product = build(:product, sku: '').save
      expect(product).to eq(false)
    end

    it 'SKU must be unique' do
      build(:product).save
      product2 = build(:product).save
      expect(product2).to eq(false)
    end

    it 'SKU must have this format 1234-ABC' do
      product = build(:product, sku: '1234ABC').save
      expect(product).to eq(false)
    end

    it 'must have a name' do
      product = build(:product, name: '').save
      expect(product).to eq(false)
    end

    it 'must have a name with minimun 3 characters' do
      product = build(:product, name: 'no').save
      expect(product).to eq(false)
    end

    it 'must have a description' do
      product = build(:product, description: '').save
      expect(product).to eq(false)
    end

    it 'must have a price' do
      product = build(:product, price: '').save
      expect(product).to eq(false)
    end

    it 'must have a stock' do
      product = build(:product, stock: '').save
      expect(product).to eq(false)
    end

    it 'must have an integer as a stock' do
      product = build(:product, stock: 'two').save
      expect(product).to eq(false)
    end

    it 'must have a tag attribute' do
      product = build(:product, tag_list: '').save
      expect(product).to eq(false)
    end
  end
end
