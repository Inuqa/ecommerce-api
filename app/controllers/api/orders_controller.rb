class Api::OrdersController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    order = user.orders.new(order_params)
    cart_params.each do |variant, quantity|
      order.line_items.new(quantity: quantity.to_i, variant_id: variant.to_i)
    end
    total = 0
    order.line_items.each do |line_item|
      total += line_item.variant.price * line_item.quantity
    end

    order.amount = total

    case order.pay_method
    when 'transfer'
      if order.save
        render json: { order: order, type: 'transfer' }, status: :created
      else
        render json: { message: 'hubo un error al crear la order, por favor intentar mas tarde' },
               status: :unprocessable_entity
      end
    when 'webpay'
      order.save
      response = Transbank::Webpay::WebpayPlus::Transaction.create(
        buy_order: order.id,
        session_id: 'noop',
        amount: total,
        return_url: 'http://localhost:2000/api/payment'
      )
      order.token = response.token
      if order.save
        render json: { res: response, order: order, type: 'webpay' }, status: :ok
      else
        render json: { message: 'hubo un error al crear la order por favor intentar mas tarde' },
               status: :unprocessable_entity
      end
    end
  end

  def commit; end

  def show; end

  private

  def order_params
    params.require(:order).permit(:name, :last_name, :address, :city, :comuna, :phone, :pay_method, :shipping_method)
  end

  def cart_params
    params.require(:cart)
  end
end
