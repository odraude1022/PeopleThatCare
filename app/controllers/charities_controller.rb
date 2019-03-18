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

  def edit
    @charity = current_charity
  end

  def update
    @charity = current_charity
    params = charity_params
    organization_name = params[:organization_name]
    tax_id = params[:tax_id]
    contact_name = params[:contact_name]
    contact_email = params[:contact_email]
    twitter_handle = params[:twitter_handle]
    website_url = params[:website_url]
    @charity.update_attribute(:organization_name, organization_name)
    @charity.update_attribute(:tax_id, tax_id)
    @charity.update_attribute(:contact_name, contact_name)
    @charity.update_attribute(:contact_email, contact_email)
    @charity.update_attribute(:twitter_handle, twitter_handle)
    @charity.update_attribute(:website_url, website_url)
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
