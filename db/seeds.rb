# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Variant.delete_all
Product.delete_all
rangesdas = 1..20
rangesdas.each do |_n|
  product = Product.new(title: FFaker::Product.product)
  product.master_image.attach(io: File.open(Rails.root.join('public/200x250.png')), filename: '200x250.png',
                       content_type: 'image/png')
  product.save!
  product.variants.create(price: 9990, size: 's', stock: 10, is_master: true)
  product.variants.create(price: 9990, size: 'm', stock: 10)
  product.variants.create(price: 9990, size: 'l', stock: 10)
end
