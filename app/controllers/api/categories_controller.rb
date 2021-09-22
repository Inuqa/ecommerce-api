class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    name = params[:name].include?('_') ? params[:name].gsub!('_', ' ') : params[:name]
    @category = Category.find_by("lower(name) = '#{name.downcase}'")
    @total_pages = (@category.products.kept.count / 12.0).ceil
  end
end
