# frozen_string_literal: false

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  describe 'POST like' do
    it 'has a 204 status code' do
      user = create(:user, id: 2)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes", headers: { Authorization: JSON.parse(response.body)['token'] }
      expect(response.status).to eq(204)
    end

    it 'should create a new like' do
      user = create(:user, id: 2)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes", headers: { Authorization: JSON.parse(response.body)['token'] }
      product = Product.find(product.id)
      expect(product.likes_number).to eq(1)
    end

    it 'should not create a new like if a user is not logged' do
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes"
      product = Product.find(product.id)
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE like' do
    it 'has a 204 status code' do
      user = create(:user, id: 2)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      token = JSON.parse(response.body)['token']
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes", headers: { Authorization: token }
      delete "/api/v1/products/#{product.id}/likes", headers: { Authorization: token }
      expect(response.status).to eq(204)
    end

    it 'should delete a like of a product' do
      user = create(:user, id: 2)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      token = JSON.parse(response.body)['token']
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes", headers: { Authorization: token }
      delete "/api/v1/products/#{product.id}/likes", headers: { Authorization: token }
      expect(product.likes_number).to eq(0)
    end

    it 'should not delete a like of a product' do
      user = create(:user, id: 2)
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }
      token = JSON.parse(response.body)['token']
      product = create(:product)
      post "/api/v1/products/#{product.id}/likes", headers: { Authorization: token }
      delete "/api/v1/products/#{product.id}/likes"
      expect(response.status).to eq(401)
      end
  end
end
