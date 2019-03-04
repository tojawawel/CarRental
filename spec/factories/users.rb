FactoryBot.define do
  factory :user do
    sequence(:email) {Faker::Internet.email}
    sequence(:username) {Faker::Internet.username(nil, "_")}
    sequence(:first_name) {Faker::Name.first_name }
    sequence(:last_name) {Faker::Name.last_name }
    sequence(:gender) {"male"}
    sequence(:phone_number) {Faker::Number.leading_zero_number(9)}
    sequence(:date_of_birth) {Faker::Date.birthday(18, 65)}
    password { Devise.friendly_token.first(8)}
  end
end
