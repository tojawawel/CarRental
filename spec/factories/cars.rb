FactoryBot.define do
  factory :car do
    brand { "MyString" }
    model { "MyString" }
    year { "2019-03-05" }
    price { 1 }
    description { "MyText" }
    user { nil }
  end
end
