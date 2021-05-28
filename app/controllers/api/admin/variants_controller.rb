class Api::Admin::VariantsController < ApplicationController
  def index
    variants = Variant.all
    render json: variants, status: :ok
  end

  def create
    variant = Product.find(params[:product_id]).variants.create(variant_params)
    render json: variant, status: :created
  end

  def update
    variant = Variant.find(params[:id])
    variant.update(params_params)
    render json: variant, status: :accepted
  end

  def destroy
    variant = Variant.find(params[:id])
    variant.destroy
    render json: :no_content
  end

  private

  def variant_params
    params.permit(:price, :size, :stock, :is_master)
  end
end
