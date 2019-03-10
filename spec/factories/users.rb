FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    username {Faker::Internet.username(nil, "_")}
    first_name {Faker::Name.first_name }
    last_name {Faker::Name.last_name }
    gender {User.genders.keys.sample}
    phone_number {Faker::Number.leading_zero_number(9)}
    date_of_birth {Faker::Date.birthday(18, 65)}
    password { Devise.friendly_token.first(8)}
    confirmed_at {Faker::Date.between(2.days.ago, Date.today)}
  end
end
