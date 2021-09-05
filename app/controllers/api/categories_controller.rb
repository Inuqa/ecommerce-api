class Api::CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: { categories: categories }, status: :ok
  end

  def show
    category = Category.find(params[:id])
    render json: category.products, status: :ok
  end
end
