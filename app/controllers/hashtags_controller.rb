class HashtagsController < ApplicationController
  def index
    @hashtags = SimpleHashtag::Hashtag.paginate(page: params[:page], per_page: 10)
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
  end
end
