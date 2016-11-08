class LikesController < ApplicationController
  before_action :set_micropost

  def create
    @like = Like.new(like_params)
    @like.micropost_id = @micropost.id
    @like.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @like = Like.find_by(user: current_user.id, micropost: params[:micropost_id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id)
  end

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
