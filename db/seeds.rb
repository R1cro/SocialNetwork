params =  {
admin:
  {
    email: "ateseyko@qulix.com",
    password:              "swseuz2U",
    password_confirmation: "swseuz2U",
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

50.times do |n|
  first_name  = Faker::Name.first_name
  second_name  = Faker::Name.last_name
  email = "user.#{n+1}@social.net"
  password = "12345678"
  User.create!(
               email: email,
               password:              password,
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
  #tag_name = Faker::Lorem.word
  content = Faker::Lorem.sentence(13)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[15..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
