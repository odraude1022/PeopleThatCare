class FollowController < ApplicationController

  def create
    @charity_id = allowed_params[:charity].to_i
    @charity = Charity.find(@charity_id)
    @user = current_user
    @user_charity = UserCharity.new(user_id: @user.id, charity_id: @charity.id)
    if @user_charity.save
      redirect_back fallback_location: "/", notice: "Now Following #{@charity.organization_name}"
    else
      redirect_back fallback_location: "/", alert: "Follow failed"
    end
  end

  def index
    if user_logged_in?
      links = UserCharity.where(user_id: current_user)
      @charities = []
      links.map do |link|
        @charities.push(Charity.find(link.charity_id))
      end
      

    elsif charity_logged_in?

    end
  end

  def destroy
    @charity_id = allowed_params[:charity].to_i
    @charity = Charity.find(@charity_id)
    @user = current_user
    UserCharity.where(user_id: @user.id).where(charity_id: @charity_id).destroy_all
    redirect_back fallback_location: "/", alert: "You are unfollowing #{@charity.organization_name}"
  end

  private
  def allowed_params
    params.permit(:charity)
  end

end
