class SearchCharitiesController < ApplicationController
  def index
    @charities = Charity.all
    @categories = Category.all
  end
end
