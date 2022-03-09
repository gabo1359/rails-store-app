# frozen_string_literal: false

require 'rails_helper.rb'

RSpec.describe 'Products API', type: :request do
  describe 'GET products' do
    it 'has a 200 status code' do
      get '/api/v1/products'
      expect(response.status).to eq(200)
    end

    it 'returns a successful response' do
      get '/api/v1/products'
      expect(response).to be_successful
    end

    it 'request list of all products' do
      create(:product)
      get '/api/v1/products'
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'show every product' do
      product = create(:product)
      get '/api/v1/products'
      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end
  end

  describe 'GET product' do
    it 'has a 200 status code' do
      product = create(:product)
      get "/api/v1/products/#{product.id}"
      expect(response.status).to eq(200)
    end

    it 'show product' do
      product = create(:product)
      get "/api/v1/products/#{product.id}"
      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end
  end

  describe 'LOGIN user' do
    it 'has a 200 status code' do
      user = create(:user)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      expect(response.status).to eq(200)
    end

    it 'return a token' do
        user = create(:user)
        post '/api/v1/auth/login', params: { email: user.email, password: user.password }
        expect(JSON.parse(response.body)).to include('token')
      end
  end

  describe 'PATCH product' do
    it 'should update a product' do
      user = create(:user)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      product = create(:product)
      patch "/api/v1/admin/products/#{product.id}", headers: { Authorization: JSON.parse(response.body)['token'] }, 
                                              params: { "product": { "description": "New description" } }
      expect(JSON.parse(response.body)['description']).to eq('New description')
    end

    it 'should not update a product if a user is not logged' do
      product = create(:product)
      patch "/api/v1/admin/products/#{product.id}", params: { "product": { "description": "New description" } }
      expect(response.status).to eq(401)
    end
  end

  describe 'POST product' do
    it 'should create a product' do
      user = create(:user)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      post "/api/v1/admin/products", headers: { Authorization: JSON.parse(response.body)['token'] }, 
                                              params: { 'product': attributes_for(:product) }
      expect(response.status).to eq(200)
    end

    it 'should not create a product if a user is not logged' do
      product = create(:product)
      post "/api/v1/admin/products", params: { 'product': attributes_for(:product) }
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE product' do
    it 'should delete a product' do
      user = create(:user)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      product = create(:product)
      delete "/api/v1/admin/products/#{product.id}", headers: { Authorization: JSON.parse(response.body)['token'] }
      expect(response.status).to eq(200)
    end

    it 'should not delete a product if a user is not logged' do
      product = create(:product)
      delete "/api/v1/admin/products/#{product.id}"
      expect(response.status).to eq(401)
    end
  end
end
