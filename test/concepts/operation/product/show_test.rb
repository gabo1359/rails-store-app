require 'test_helper'

class OperationProductShowTest < ActiveSupport::TestCase
  test 'show product' do
    result = Operation::Product::Show.call(params: { id: 2 })  

    assert_equal true, result.success?
  end
end