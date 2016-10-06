class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.reorder("email").paginate(page: params[:page], :per_page => 4)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 3)
    @micropost = current_user.microposts.build if logged_in?
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_create_params)
      flash[:success] = "Done"
    end
    render 'edit'
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      send_activation_mail
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def send_activation_mail
    UserMailer.account_activation(@user).deliver_now
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def current_user?(user)
    user == current_user
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], :per_page => 16)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 16)
    render 'show_follow'
  end

  private
  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 user_profile_attributes: [:first_name, :second_name, :city, :birthday, :id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
