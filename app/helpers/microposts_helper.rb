module MicropostsHelper
  HASHTAG_REGEX = /(?:(?<=\s)|^)#(\w*[A-Za-z_]+\w*)/i

  def find_hashtag(content)
    hashtagged_content = content.to_s.gsub(HASHTAG_REGEX) do
      link_to($&, tag_path($1),  {class: :tag_list})
    end
    hashtagged_content.html_safe
  end
end
