class Admin::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: :ok
  end

  def create
    product = Product.create(product_params)
    render json: product, status: :created
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
    render json: product, status: :accepted
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: :no_content
  end

  private

  def product_params
    params.permit(:title)
  end
end
