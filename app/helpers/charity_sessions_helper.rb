module CharitySessionsHelper
  def charity_log_in(charity)
    session[:charity_id] = charity.id
  end

  def current_charity
    if session[:charity_id]
      @current_charity ||= Charity.find_by(id: session[:charity_id])
    end
  end

  def charity_logged_in?
    !current_charity.nil?
  end

  def charity_log_out
    session.delete(:charity_id)
    @current_charity = nil
  end
end
