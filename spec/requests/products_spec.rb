require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    it 'has a 200 status code' do
      get '/products'
      expect(response.status).to eq(200)
    end

  #   it "contains the product id" do
  #     product = build(:product)
  #     get "/products/id"
  #     expect(response).to include product.id
  #  end
  # end

  # describe "GET /show" do
  #   it 'has a 200 status code' do
  #     get '/products/:id'
  #     expect(response.status).to eq(200)
  #   end
  end
end
