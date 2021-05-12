json.extract! @product, :id, :title
json.url polymorphic_url(@product.master_image)
json.master_price @product.master.price
json.variants @product.variants, :id, :price, :stock, :size
