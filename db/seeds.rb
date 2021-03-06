params =  {
  admin: {
    email: "ateseyko@qulix.com",
    password:              "12345678",
    password_confirmation: "12345678",
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes: {
      first_name: "Anatoly",
      second_name: "Teseyko",
      remote_avatar_url: "http://res.cloudinary.com/r1cro-socialnetwork/image/upload/v1476808829/defaultavatar_oqsdpi.png"
    }
  }
}

User.create!(params[:admin])

50.times do
  first_name  = Faker::Name.first_name
  second_name  = Faker::Name.last_name
  email = Faker::Internet.free_email
  password = "12345678"
  get_person = Net::HTTP.get(URI('https://randomuser.me/api/'))
  avatar_url = JSON.parse(get_person)['results'][0]['picture']['large']
  User.create!(
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes:  {
      first_name: first_name,
      second_name: second_name,
      remote_avatar_url: avatar_url
    }
  )
end

users = User.order(:created_at).take(50)

20.times do
  content = Faker::Lorem.sentence(15)
  words = content.scan(/\b([A-Za-z]+)\b*\b/i)
  rand(4).times do
    tag = words[rand(words.size)].sample.to_s
    content.gsub!(tag, '#' + tag)
  end
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
2000.times do
  flag = [true, false].sample
  user1 = users.sample
  user2 = users.sample
  if flag == true
    if user1 != user2 && !user1.followers.include?(user2) && rand(100).even?
      user2.follow(user1)
    end
    if user1 != user2 && user1.following.include?(user2) && rand(100).even?
      user1.unfollow(user2)
    end
  end
end

10000.times do
  flag = [true, false].sample
  if flag == true
   Like.find_or_create_by(user_id: rand(50), micropost_id: rand(1000))
  end
end
