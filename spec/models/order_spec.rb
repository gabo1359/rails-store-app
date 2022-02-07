require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'order model validation' do
    it 'must have a quantity greater than 0' do
      order = create(:order)
      expect(order.quantity).to be > 0
    end
  end
end
