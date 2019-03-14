class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user_log_in user
      redirect_to user
    else
      redirect_to user_login_path, alert: "Invalid email/password"
    end
  end


  def destroy
    user_log_out
    redirect_to root_url
  end

end
