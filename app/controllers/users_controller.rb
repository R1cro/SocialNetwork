class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_profile_params)
      flash[:success] = "Done."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_all_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Social Network!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_all_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

  def user_profile_params
    user_all_params.except(:email)
  end
end
