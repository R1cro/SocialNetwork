params =  {
admin:
  {
    email: "ateseyko@qulix.com",
    password:              "12345678",
    password_confirmation: "12345678",
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes:  {
      first_name: "Anatoly",
      second_name: "Teseyko"
    }
  }
}

User.create!(params[:admin])

50.times do
  first_name  = Faker::Name.first_name
  second_name  = Faker::Name.last_name
  email = Faker::Internet.free_email
  password = "12345678"
  User.create!(
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes:  {
      first_name: first_name,
      second_name: second_name
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

# users = User.all
# users.each do |user|
#   x = rand(50)
#   y = rand(x)
#   following = users[rand(y)..rand(x)]
#   followers = users[rand(y)..rand(x)]
#
#   following.each { |followed| user.follow(followed) }
#   followers.each { |follower| follower.follow(user) }
# end
