json.orders @orders do |order|
  json.extract! order, :id, :status
  json.created_at order.created_at.strftime('%d/%m/%Y')
  json.email order.user.email
  total = 0
  order.line_items.each do |line_item|
    total += line_item.variant.price * line_item.quantity
  end
  json.total total
end
json.statuses @statuses
json.total_pages @pages
