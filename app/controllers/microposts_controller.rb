class MicropostsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to current_user
    else
      # Need to fix!
      flash[:danger] = 'Post can\'t be empty'
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

end
