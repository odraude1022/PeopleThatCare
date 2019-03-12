class CharitiesController < ApplicationController
  before_action :set_charity, only: [:show]
  before_action :verify_current_charity, only: [:show]

  def show
  end

  def new
    @charity = Charity.new
  end

  def create
    @charity = Charity.new(charity_params)
    if @charity.save
      charity_log_in @charity
      redirect_to @charity
    else
      render 'new'
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
                                    :password, :password_confirmation)
  end

end
