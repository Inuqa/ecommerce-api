class Api::Admin::ProductsController < ApplicationController
  before_action :authorized

  def index
    @products = Product.kept
    @products = filter(@products)
    @total_pages = (@products.count / 10.0).ceil
    @products = @products.offset(params[:offset]) if params[:offset].present?
    @products = @products.limit(10)
  end

  def create
    product = Product.new(product_params)
    product.discard
    if product.save
      render json: product, status: :created
    else
      render json: errors, status: :bad_request
    end
  end

  def edit
    product = Product.find(params[:id])

    if product
      render json: { product: product, image: polymorphic_url(product.master_image) }, status: :ok
    else
      render json: { message: 'Producto no encontrado' }, status: :not_found
    end
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
    render json: product, status: :accepted
  end

  def destroy
    product = Product.find(params[:id])
    product.discard
    render json: :no_content
  end

  def restore
    product = Product.find(params[:id])
    if product.undiscard
      render json: product, status: :ok
    else
      render json: { message: 'Producto no pudo ser recuperado' }, status: :method_not_allowed
    end
  end

  private

  def filter(products)
    products = Product.all if params[:show_deleted] == 'true'
    products = Product.filter_by_title(params[:title]) if params[:title].present?
    products.order(id: :asc)
  end

  def product_params
    params.require(:product).permit(:title, :master_image)
  end
end
