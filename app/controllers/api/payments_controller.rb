class Api::PaymentsController < ApplicationController
  def commit
    if params[:TBK_TOKEN].present?
      order = Order.find_by(token: params[:TBK_TOKEN])
      redirect_to "http://localhost:3000/transactions/#{order.uuid}"
    elsif params[:token_ws]
      @token = params[:token_ws]
      order = Order.find_by(token: @token)
      res = Transbank::Webpay::WebpayPlus::Transaction.commit(token: @token)

      order.payments.create(payload: res)
      if res.status == 'AUTHORIZED'
        order.status = 'pagado'
        order.save
      end
      redirect_to "http://localhost:3000/transactions/#{order.uuid}"
    end
  end

  def show
    order = Order.find_by(uuid: params[:uuid])
    render json: order
  end
end
