json.extract! @product, :id, :title
json.url polymorphic_url(@product.master_image)
json.master_price @product.master.price
json.variants @product.variants do |variant|
  json.id variant.id
  json.title @product.title
  json.image polymorphic_url(@product.master_image)
  json.price variant.price
  json.stock variant.stock
  json.size variant.size
end
