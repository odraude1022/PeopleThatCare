class Users::CharitiesController < ApplicationController
  before_action :set_charity, except: :index

  def destroy
    user_charity = UserCharity.where(user_id: params[:user_id], charity_id: @charity.id)
    if user_charity.destroy_all
      redirect_back fallback_location: "/", notice: "You are unfollowing #{@charity.organization_name}"
    else
      redirect_back fallback_location: "/", alert: "You have failed to unfollow #{@charity.organization_name}"
    end
  end

  def update
    if current_user.charities << @charity
      redirect_back fallback_location: "/", notice: "Now Following #{@charity.organization_name}"
    else
      redirect_back fallback_location: "/", alert: "Follow failed"
    end
  end

  def index
    @charities = current_user.charities
    render "user_charities/index"

  end

  private

  def set_charity
    @charity = Charity.find(params[:id])
  end
end
