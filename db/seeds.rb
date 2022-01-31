# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

sku_letters = ('AAA'..'ZZZ').to_a

Product.destroy_all

15.times do |i|
  Product.create({
    sku: "#{rand(1000..9999)}-#{sku_letters[rand(0...sku_letters.length)]}",
    name: Faker::Commerce.product_name,
    description: Faker::Commerce.department,
    price: rand(1..15),
    stock: rand(10..50)
  })
end