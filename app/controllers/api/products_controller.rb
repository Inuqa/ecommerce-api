class Api::ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:variants).offset(params[:offset].to_i).limit(8)
    @total_pages = (Product.all.count / 8.0).ceil
  end

  def show
    @product = Product.find(params[:id])
  end
end
