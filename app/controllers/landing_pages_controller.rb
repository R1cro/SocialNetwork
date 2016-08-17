class LandingPagesController < ApplicationController
  before_action :redirect_to_profile, only: :home

  def home
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
