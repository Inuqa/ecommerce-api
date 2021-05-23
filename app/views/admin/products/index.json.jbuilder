json.products @products do |product|
  json.extract!(product, :id, :title, :discarded_at)
  json.image polymorphic_url(product.master_image)
  json.price product.master.price
end
json.total_count @total_pages
