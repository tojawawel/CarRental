FactoryBot.define do
  factory :user do
    sequence(:email) {Faker::Internet.email}
    sequence(:username) {Faker::Internet.username(/\A[\w]*\z/)}
    password { Devise.friendly_token.first(8)}
  end
end
