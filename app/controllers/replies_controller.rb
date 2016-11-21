class RepliesController < ApplicationController
  before_action :set_micropost

  def create
    @reply = Reply.new(reply_params)
    @reply.micropost_id = @micropost.id
    if @reply.save
      redirect_to :back
    else
      redirect_to :back, flash: { danger: @micropost.errors.full_messages.join('<br><li>') }
    end
  end

  def destroy
    @reply = Reply.find_by(id: params[:micropost_id])
    @reply.destroy
    flash[:success] = 'Your reply deleted!'
    redirect_to request.referrer
  end

  private
  def reply_params
    params.require(:reply).permit(:content, :image, :micropost_id, :user_id)
  end

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
