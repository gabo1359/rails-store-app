require 'test_helper'

class OperationUserShowTest < ActiveSupport::TestCase
  test 'show user' do
    result = Operation::User::Show.call(params: { id: 1 })  

    assert_equal true, result.success?
  end
end