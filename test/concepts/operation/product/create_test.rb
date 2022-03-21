require 'test_helper'

class OperationProductCreateTest < ActiveSupport::TestCase
  test 'creates product with provided attributes' do
    result = Operation::Product::Create.call(
        params: { product: { sku: '1234-ABC', name: 'Product name', description: 'Anything', price: 1, stock: 20 } },  errors: {})  
    # p result[:model].to_json    
    assert_equal true, result.success?
  end

  test 'fails with invalid params' do
    result = Operation::Product::Create.call(
        params: {}, errors: {})  
   
    assert_equal false, result.success?
    assert_equal({}, result[:errors])
  end

  test 'fails with invalid attributes' do
    result = Operation::Product::Create.call(
        params: { product: { sku: '', name: '', description: '', stock: '' } }, errors: {})  

    assert_equal false, result.success?
    assert_equal(["can't be blank", "format 1234-ABC"], result[:errors][:type].to_hash[:sku])
    assert_equal(["must be given please", "is too short (minimum is 3 characters)"], result[:errors][:type].to_hash[:name])
    assert_equal(["can't be blank"], result[:errors][:type].to_hash[:description])
    assert_equal(["can't be blank"], result[:errors][:type].to_hash[:price])
    assert_equal(["can't be blank", "is not a number"], result[:errors][:type].to_hash[:stock])
  end
end