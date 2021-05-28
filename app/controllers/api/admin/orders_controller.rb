class Api::Admin::OrdersController < ApplicationController
  before_action :authorized

  def index
    @orders = Order.all
    @statuses = Order.statuses.keys
    @orders = filter(@orders)
    @pages = (@orders.count / 10.0).ceil
    @orders = @orders.offset(params[:offset]) if params[:offset].present?
    @orders = @orders.limit(10)
  end

  private

  def filter(orders)
    orders = orders.filter_by_id(params[:order_id]) if params[:order_id].present?
    orders = orders.filter_by_email(params[:email]) if params[:email].present?
    orders = orders.filter_by_status(params[:status]) if params[:status].present?
    orders
  end
end
