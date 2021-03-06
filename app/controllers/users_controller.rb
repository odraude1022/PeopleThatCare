class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :verify_current_user, only: [:show]

  def show
    @charities = current_user.charities
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_log_in @user
      redirect_to @user
    else
      redirect_to new_user_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to user, notice: "Successfully updated profile"
    else
      redirect_to user, alert: user.errors.full_messages.to_sentence
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def verify_current_user
    redirect_to root_path unless current_user&.id == @user.id
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation, :avatar)
  end
end
