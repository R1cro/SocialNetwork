class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_strong_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Social Network!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_strong_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
