FactoryBot.define do
  factory :food_item do
    name { Faker::Food.dish }
    price { Faker::Commerce.price(range: 2..10) }
    course { Faker::Commerce.price(range: 0..2) }
    daily_menu
  end
end
