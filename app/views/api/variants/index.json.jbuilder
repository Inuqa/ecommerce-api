json.variants @variants do |variant|
  json.extract!(variant, :id, :price, :size)
  json.title variant.product.title
  json.image polymorphic_url(variant.product.master_image)
end
