# frozen_string_literal: false

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET products' do
    it 'has a 200 status code' do
      get '/products'
      expect(response.status).to eq(200)
    end

    it 'returns a successful response' do
      get '/products'
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/products'
      expect(response).to render_template('index')
    end

    it 'request list of all products' do
      create(:product, name: 'product')
      get products_path
      expect(response).to be_successful
      expect(response.body).to include('product')
    end

    it 'show every product' do
      product = create(:product)
      get product_path(product)
      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end

    it 'show every review of a product' do
      product = create(:product)
      review = create(:review, product: product)
      get product_path(product)
      expect(response).to be_successful
      expect(response.body).to include(review.title)
    end
  end

  describe 'POST products' do
    it 'should create a new product' do
      user = create(:user, admin: true)
      post '/products', params: attributes_for(:product, user: user)
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end
end
