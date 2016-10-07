class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
    redirect_to root_path #temp
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @micropost = Micropost.tagged_with(@tag.name)
  end
end
