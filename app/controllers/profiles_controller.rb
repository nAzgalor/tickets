class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit
  end

  def update
    user_attributes = params[:user][:password].blank? ? user_params.except(:password, :password_confirmation) : user_params

    if @user.update(user_attributes)
      redirect_to edit_profile_path, notice: 'You account was updated'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
