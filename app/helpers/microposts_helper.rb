module MicropostsHelper

  def find_hashtag(micropost)
    micropost.tag_list.each do |tag|
       micropost.content.gsub!(/#\b#{tag}\b/i) do
       link_to('#' + tag, tag_path(tag_id_by_name(tag)))
      end
    end
    micropost.content.html_safe
  end

  def tag_id_by_name(name)
    ActsAsTaggableOn::Tag.find_by_name(name)&.id
  end

end
