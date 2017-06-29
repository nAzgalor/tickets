class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.available_to_message(current_user.id)
  end
end
