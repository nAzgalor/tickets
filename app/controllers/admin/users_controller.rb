class Admin::UsersController < AdminController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def new
    @user = User.new
  end

  def update
    user_attributes = params[:user][:password].blank? ? user_params.except(:password, :password_confirmation) : user_params
    if @user.update(user_attributes)
      redirect_to admin_users_path, notice: 'User was updated'
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User was created'
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :blocked)
  end
end
