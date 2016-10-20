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
  tag_name = Faker::Lorem.word
  content = '#' + tag_name + Faker::Lorem.sentence(13)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[1..20]
followers = users[15..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
