FactoryBot.define do
  factory :user_review do
    title { "MyString" }
    content { "MyString" }
    for_user { 1 }
    by_user { 1 }
  end
end
