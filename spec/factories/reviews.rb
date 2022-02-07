FactoryBot.define do
  factory :review do
    user
    product 
    title {'title'}
    content {'description'}
    rating {3}
  end
end