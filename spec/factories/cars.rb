FactoryBot.define do
  factory :car do
    brand { "Audi" }
    model { "A4" }
    year { "2019-03-05" }
    price { 120 }
    description { "ebe ebe ebe" }
    carpic { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/cover_image.png'), 'image/png') }
    user { FactoryBot.create(:user) }
  end
end
