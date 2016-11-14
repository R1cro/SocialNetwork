class TagsController < ApplicationController

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @micropost = Micropost.tagged_with(@tag.name)
  end
end
