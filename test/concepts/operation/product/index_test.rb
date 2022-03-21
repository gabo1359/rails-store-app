require 'test_helper'

class OperationProductIndexTest < ActiveSupport::TestCase
  test 'show products' do
    result = Operation::Product::Index.call(params: {})  
   
    assert_equal true, result.success?
  end
end