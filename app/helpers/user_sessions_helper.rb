module UserSessionsHelper

  # Logs in the given user
  def user_log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user, if he/she exists
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, and false if not
  def user_logged_in?
    !current_user.nil?
  end

  # Logs out user
  def user_log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
