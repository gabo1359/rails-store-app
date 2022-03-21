require 'test_helper'

class OperationUserCreateTest < ActiveSupport::TestCase
  test 'creates user with provided attributes' do
    result = Operation::User::Create.call(
        params: { user: { first_name: 'Juan', last_name: 'Perez', address: 'My address', phone: '987654321', email: 'juan@applaudo.com', password: '123456' } },  errors: {})  
    
    assert_equal true, result.success?
  end

  test 'fails with invalid params' do
    result = Operation::User::Create.call(
        params: {}, errors: {})  
   
    assert_equal false, result.success?
    assert_equal({}, result[:errors])
  end

  test 'fails with invalid attributes' do
    result = Operation::User::Create.call(
        params: { user: { first_name: '', last_name: '', email: '', password: '' } }, errors: {})  

    assert_equal false, result.success?
    assert_equal(["can't be blank"], result[:errors][:type].to_hash[:first_name])
    assert_equal(["can't be blank"], result[:errors][:type].to_hash[:last_name])
    assert_equal(["can't be blank", "is invalid"], result[:errors][:type].to_hash[:email])
    assert_equal(["can't be blank", "is too short (minimum is 6 characters)"], result[:errors][:type].to_hash[:password])
  end
end