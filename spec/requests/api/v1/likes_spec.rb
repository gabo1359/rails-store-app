require 'swagger_helper'

RSpec.describe 'api/v1/likes', type: :request do

  path '/api/v1/products/{product_id}/likes' do
    # You'll want to customize the parameter types...
    parameter name: 'product_id', in: :path, type: :string, description: 'product_id'

    get('new like') do
      response(200, 'successful') do
        let(:product_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  
  path '/api/v1/products/{product_id}/likes' do
    # You'll want to customize the parameter types...
    parameter name: 'product_id', in: :path, type: :string, description: 'product_id'

    delete('delete like') do
      response(200, 'successful') do
        let(:product_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create like') do
      response(200, 'successful') do
        let(:product_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
