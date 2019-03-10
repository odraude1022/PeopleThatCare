class CharitySessionsController < ApplicationController
  def new
  end

  def create
    charity = Charity.find_by(contact_email: params[:charity_session][:contact_email].downcase)
    if charity && charity.authenticate(params[:charity_session][:password])
      charity_log_in charity
      redirect_to charity
    else
      render 'new', alert: 'Invalid email/password'
    end
  end

  def destroy
    charity_log_out
    redirect_to root_url
  end
end
