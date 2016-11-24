class LandingPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost  =  @user.microposts.build
      @feed_items =  @user.feed.paginate(page: params[:page], :per_page => 4)
    else
      @feed_items =  Micropost.order('created_at').paginate(page: params[:page], :per_page => 7)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
