class Admin::ProductsController < ApplicationController
  def index
    @products = Product.kept
    @products = filter(@products)
    @total_pages = (@products.count / 10.0).ceil
    @products = @products.offset(params[:offset]) if params[:offset].present?
    @products = @products.limit(10)
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

  def filter(products)
    products = Product.all if JSON.parse(params[:show_deleted])
    products = Product.filter_by_title(params[:title]) if params[:title].present?
    products
  end

  def product_params
    params.permit(:title)
  end
end
