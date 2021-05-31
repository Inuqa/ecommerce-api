class Api::PaymentsController < ApplicationController
  def commit
    @token = params[:token_ws]
    order = Order.find_by(token: @token)
    res = Transbank::Webpay::WebpayPlus::Transaction.commit(token: @token)

    if res.status == 'AUTHORIZED'
      order.status = 'pagado'
      order.save
    end
    redirect_to "http://localhost:3000/transactions/#{order.id}"
  end

  def show
    @order = Order.find(params[:id])
  end
end
