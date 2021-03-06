json.products @products do |product|
  json.extract!(product, :id, :title)
  json.master_image polymorphic_url(product.master_image)
  json.price product.master.price if product.master
end
json.total_count @total_pages
