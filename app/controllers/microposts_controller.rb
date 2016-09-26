class MicropostsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to current_user
    else
      redirect_to :back, flash: { danger: @micropost.errors.full_messages.join("<br>") }
    end
  end

  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

end
