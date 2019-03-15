class FollowController < ApplicationController

  def create
    @charity_id = allowed_params[:charity].to_i
    @charity = Charity.find(@charity_id)
    @user = current_user
    @user_charity = UserCharity.new(user_id: @user.id, charity_id: @charity.id)
    if @user_charity.save
      redirect_back fallback_location: "/", notice: "Now Following #{@charity.organization_name}"
    else
      edirect_back fallback_location: "/", alert: "Follow failed"
    end
  end

  def index

  end

  private
  def allowed_params
    params.permit(:charity)
  end

end
