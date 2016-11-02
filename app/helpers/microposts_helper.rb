module MicropostsHelper
  URL_REG = /(?:(?:https?|ftp|file):\/\/|ftp\.)(?:\([-A-Z0-9+&@#%=~_|$?!:,.]*\)|[-A-Z0-9+&@#\/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[A-Z0-9+&@#\/%=~_|$])/i
  IMG_REG = /(?:png|jpe?g|gif|svg)$/

  def find_hashtag(micropost)
    micropost.tag_list.each do |tag|
      micropost.content.gsub!(/#\b#{tag}\b/i) do
        link_to('#' + tag, tag_path(tag_id_by_name(tag)))
      end
    end
    micropost.content.html_safe
  end

  def find_urls(micropost)
    micropost.content.gsub!(URL_REG) do |url|
      if url[IMG_REG]
        "<img src='#{url}'/>"
      else
        "<a href='#{url}'>#{url}</a>"
      end
    end
  end

  def process_content(micropost)
    find_urls(micropost)
    find_hashtag(micropost)
  end

  def tag_id_by_name(name)
    ActsAsTaggableOn::Tag.find_by_name(name)&.id
  end

end
