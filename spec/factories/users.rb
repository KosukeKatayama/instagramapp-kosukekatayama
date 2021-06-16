FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    username { 'TEST_USER' }
  end
end
