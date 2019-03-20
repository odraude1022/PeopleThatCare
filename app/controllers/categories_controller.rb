class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.json do
        render json: { categories: @categories}
      end
    end
  end

  def show
    @category = Category.find(params[:id])
    @charity_categories = @category.charity_categories
  end
end
