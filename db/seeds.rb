# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

sku_letters = ('AAA'..'ZZZ').to_a
categories = %w[ Beverages Cereals Dairy Fats Nuts Seeds Sauces Soups Snacks Desserts Miscellaneous ]

Product.destroy_all
User.destroy_all
Review.destroy_all

User.create(
  email: 'admin@applaudo.com',
  password: '123456',
  first_name: 'Admin',
  last_name: 'Applaudo Studios',
  phone: '123-456-7890',
  address: 'Salvador',
  admin: true
)

User.create(
  email: 'anonymous@applaudo.com',
  password: '123456',
  first_name: 'Anonymous',
  last_name: 'User',
  phone: '000-000-0000',
  address: 'Some place'
)

User.create(
  email: 'support@applaudo.com',
  password: '123456',
  first_name: 'Support',
  last_name: 'User',
  phone: '123-456-7890',
  address: 'Web',
  support: true
)

User.create(
  email: 'gabriel@applaudo.com',
  password: '123456',
  first_name: 'Gabriel',
  last_name: 'Llerena Quenaya',
  phone: '123-456-7890',
  address: 'Arequipa'
)

30.times do |i|
  i = 0
  tag_list = []
  while i < 2
    sample = categories.sample
    if !tag_list.include? sample
      tag_list << sample
      i += 1
    end
  end

  product = Product.create({
    sku: "#{rand(1000..9999)}-#{sku_letters[rand(0...sku_letters.length)]}",
    name: Faker::Commerce.product_name,
    description: Faker::Commerce.department,
    price: rand(1..15),
    stock: rand(10..50),
    tag_list: tag_list.join(', ')
  })
  product.reviews.create({
    title: 'Excellent product!', 
    content: 'Some description for the product', 
    rating: rand(1..5),
    user_id: 3
  })
end

puts 'Successfully seed!'