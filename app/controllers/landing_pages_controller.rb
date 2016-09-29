class LandingPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost  =  @user.microposts.build
      @feed_items =  @user.feed.paginate(page: params[:page])
    else
      @feed_items =  Micropost.order('created_at').paginate(page: params[:page], :per_page => 3)
    end
  else

  end

  def help
  end

  def about
  end

  def contact
  end
  private
    def redirect_to_profile
      if current_user != nil
        redirect_to current_user
      end
    end
end
