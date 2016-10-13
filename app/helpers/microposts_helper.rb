module MicropostsHelper

  def find_hashtag(micropost)
    micropost.tag_list.each do |t|
      micropost.content.gsub!(t) do
        link_to(t, tag_path(tag_id_by_name(t)))
      end
    end
    micropost.content.html_safe
  end

  def tag_id_by_name(name)
    ActsAsTaggableOn::Tag.find_by_name(name)&.id
  end

end
