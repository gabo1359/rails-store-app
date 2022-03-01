# frozen_string_literal: false

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET orders' do
    before :each do
      create(:user, id: 2)
    end

    it 'has a 200 status code' do
      get '/api/v1/orders'
      expect(response.status).to eq(200)
    end

    it 'returns a successful response' do
      get '/api/v1/orders'
      expect(response).to be_successful
    end
  end
end
