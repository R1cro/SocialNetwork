class RepliesController < ApplicationController
  before_action :set_micropost

  def create
    @reply = Reply.new(reply_params)
    @reply.micropost_id = @micropost.id
    @reply.save
    respond_to do |format|
      format.html {
        if @reply.save
          redirect_to :back
        else
          redirect_to :back, flash: { danger: @reply.errors.full_messages.join('<br><li>') }
        end
      }
      format.js
    end

  end

  def destroy
    @reply = Reply.find_by(id: params[:micropost_id])
    @reply.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Your reply deleted!'
        redirect_to request.referrer
      }
      format.js
    end

  end

  private
  def reply_params
    params.require(:reply).permit(:content, :image, :micropost_id, :user_id)
  end

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
