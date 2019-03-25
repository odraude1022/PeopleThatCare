class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user_log_in user
      params[:session][:remember_me] == '1' ? user_remember(user) : user_forget(user)
      redirect_to user
    else
      redirect_to user_login_path, alert: "Invalid email/password"
    end
  end

  def destroy
    user_log_out if user_logged_in?
    redirect_to root_url
  end
end
