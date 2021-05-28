class Api::PaymentsController < ApplicationController
  def commit
    @token = params[:token_ws]
    res = Transbank::Webpay::WebpayPlus::Transaction.commit(token: @token)

    redirect_to 'http://localhost:3000/products'
  end
end
