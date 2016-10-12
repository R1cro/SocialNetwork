module MicropostsHelper

  def find_hashtag(micropost)
    tag = micropost.tag_list
    content = micropost.content
    tag.each do |t|
      content.gsub!(t) do
        link_to(t, tag_path(tag_id_by_name(t)))
      end
    end
    content.html_safe
  end

  def tag_id_by_name(name)
    ActsAsTaggableOn::Tag.find_by_name(name)&.id
  end

end
