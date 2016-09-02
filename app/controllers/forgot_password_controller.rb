class ForgotPasswordController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:forgot_password][:email].downcase)
    if @user
      @user.create_reset_digest
      UserMailer.forgot_password(@user).deliver
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
end
