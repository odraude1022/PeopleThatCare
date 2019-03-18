class CharitiesController < ApplicationController
  before_action :set_charity, only: [:show]

  def show
    @charity = Charity.find(params[:id])
    @news_posts = @charity.news_posts
  end

  def new
    @charity = Charity.new
    @categories = Category.all
  end

  def create
    @charity = Charity.new(charity_params)
    # STILL NEED SOME MORE WORK WITH PARAMS
    # params[:categories].each do |category_id|
    #   category = Category.find(category_id) if category_id != ""
    #   @charity.categories.push(category)
    # end 
    if @charity.save
      charity_log_in @charity
      redirect_to @charity
    else
      redirect_to new_charity_path, alert: @charity.errors.full_messages.to_sentence
    end
  end

  private

  def set_charity
    @charity = Charity.find(params[:id])
  end

  def verify_current_charity
    redirect_to root_path unless current_charity&.id == @charity.id
  end

  def charity_params
    params.require(:charity).permit(:organization_name, :tax_id, :contact_name,
                                    :contact_email, :website_url, :twitter_handle,
                                    :password, :password_confirmation, :avatar)
  end

end
