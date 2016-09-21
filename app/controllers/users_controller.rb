class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], :per_page => 4)
  end

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
    @user = User.new(user_create_params)
    if @user.save
      send_activation_mail
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Access to this page allowed only for users. Sign in to access this page."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def send_activation_mail
    UserMailer.account_activation(@user).deliver_now
  end

  private
  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


  def user_profile_params
    params.require(:user).permit(:first_name, :second_name, :birthday, :city, :password, :password_confirmation)
  end
end
