class TagsController < ApplicationController

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @tagged_microposts = Micropost.tagged_with(@tag.name)
    #@tagged_microposts << Reply.tagged_with(@tag.name)
    @reply_tags = Reply.tagged_with(@tag.name)
  end
end
