FactoryBot.define do
  factory :order do
    user
    product
    quantity {3}
  end
end