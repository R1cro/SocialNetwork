class TagsController < ApplicationController

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @tagged =  Micropost.tagged_with(@tag.name) + Reply.tagged_with(@tag.name)
  end
end
