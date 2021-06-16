FactoryBot.define do
  factory :article do
    content { Faker::Lorem.characters(number: 20) }
  end
end
