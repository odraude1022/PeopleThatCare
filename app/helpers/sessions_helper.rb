module SessionsHelper

  # Logs in the given user
  def log_in(user)
    sessions[:user_id] = user.id
  end

  # Returns the current logged-in user, if he/she exists
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, and false if not
  def logged_in?
    !current_user.nil?
  end

  # Logs out user
  def log_out
    sessions.delete(:user_id)
    @current_user = nil
  end

end
