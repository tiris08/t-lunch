# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

drinks = ["Coke", "Juice", "Tea", "Coffe", "Water"]

99.times do |day|
  # imitate history of created menues on working days only
  time = 2.month.ago + day.day
  if time.on_weekday? && !(time > Time.now)
    menu = DailyMenu.create(created_at: time)
    3.times do 
      name = Faker::Food.dish
      price = Faker::Commerce.price(range: 5..10)
      menu.food_items.create(name: name, price: price, course: 0)
      name = Faker::Food.dish
      price = Faker::Commerce.price(range: 7..10)
      menu.food_items.create(name: name, price: price, course: 1)
      name = drinks.sample
      price = Faker::Commerce.price(range: 2..5)
      menu.food_items.create(name: name, price: price, course: 2)
    end
  end
end