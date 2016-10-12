class MicropostsController < ApplicationController
  HASHTAG_REGEX = /(?:(?<=\s)|^)#(\w*[A-Za-z_]+\w*)/i

  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    save_hashtags(@micropost)
    if @micropost.save
      redirect_to root_path
    else
      redirect_to :back, flash: { danger: @micropost.errors.full_messages.join('<br><li>') }
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to request.referrer
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image, :id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def save_hashtags(micropost)
    tags = micropost.content.scan(HASHTAG_REGEX)
    micropost.tag_list.add(tags)
  end

end
