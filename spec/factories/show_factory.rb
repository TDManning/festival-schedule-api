FactoryBot.define do
  factory :show do
    artist { Faker::Music.band }
    location { Faker::Address.city }
    # time_slot { rand(1..5) }
    image_url { Faker::Internet.url }
  end
end
