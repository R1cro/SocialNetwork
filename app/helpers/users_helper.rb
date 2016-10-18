module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # get_person = Net::HTTP.get(URI('https://randomuser.me/api/'))
    # get_avatar = JSON.parse(get_person)['results'][0]['picture']['medium']
    # gravatar_url = get_avatar
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end
