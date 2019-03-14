module CharitySessionsHelper
  def charity_log_in(charity)
    session[:charity_id] = charity.id
  end

  # Remembers a charity in a persistent session.
  def charity_remember(charity)
    charity.remember
    cookies.permanent.signed[:charity_id] = charity.id
    cookies.permanent[:remember_token] = charity.remember_token
  end

  def current_charity
    if (charity_id = session[:charity_id])
      @current_charity ||= Charity.find_by(id: charity_id)
    elsif (charity_id = cookies.signed[:charity_id])
      charity = Charity.find_by(id: charity_id)
      if charity && charity.authenticated?(cookies[:remember_token])
        charity_log_in charity
        @current_charity = charity
      end
    end
  end

  # Returns true if the user is logged in, and false if not
  def charity_logged_in?
    !current_charity.nil?
  end

  def charity_forget(charity)
    charity.forget
    cookies.delete(:charity_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current charity.
  def charity_log_out
    charity_forget(current_charity)
    session.delete(:charity_id)
    @current_charity = nil
  end
end
