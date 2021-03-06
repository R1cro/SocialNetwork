class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        if params[:session][:remember_me] == '1'
          remember(user)
        else
          forget(user)
        end
        redirect_back_or root_url
      else
        flash[:danger] = "Your account not activated. Check your email for the activation link."
        redirect_to root_url
      end
    else
      flash.now[:danger]  = 'Invalid email/password combination! Please, try again.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
