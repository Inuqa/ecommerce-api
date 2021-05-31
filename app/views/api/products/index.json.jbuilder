json.products @products do |product|
  json.extract!(product, :id, :title)
  json.url url_for(product.master_image)
  json.price product.master.price if product.master
end
json.total_count @total_pages
