module UsersHelper
  DEFAULT_AVATAR = 'http://res.cloudinary.com/r1cro-socialnetwork/image/upload/v1476871369/defaultavatar_blue_msvxkv.jpg'

  def avatar_for(user, size)
    avatar_url = if user.user_profile.avatar.url.present?
                   user.user_profile.avatar.url
                 else
                   DEFAULT_AVATAR
                 end
    image_tag(avatar_url, alt: user.email, class: "avatar", width: size)
  end
end
