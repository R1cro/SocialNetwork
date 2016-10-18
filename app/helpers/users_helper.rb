module UsersHelper
  def avatar_for(user, size)
    if user.user_profile.avatar.url.present?
      avatar_url = user.user_profile.avatar.url
    else
      avatar_url = 'http://res.cloudinary.com/r1cro-socialnetwork/image/upload/v1476808829/defaultavatar_oqsdpi.png'
    end
    image_tag(avatar_url, alt: user.email, class: "avatar", width: size)
  end
end
