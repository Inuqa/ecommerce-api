class Api::Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]
  before_action :authorized

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    render json: category, status: :ok
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: 'algo salio mal', status: :bad_request
    end
  end

  def destroy
    @category.destroy
    render json: 'categoria borrada', status: :no_content
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: 'algo salio mal', status: :bad_request
    end
  end

  private

  def set_category
    @category = Categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
