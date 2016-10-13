params =  {
  me:
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
    },
  user_1: {
    email: "r1cro@qulix.com",
    password:              "swseuz2U",
    password_confirmation: "swseuz2U",
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes:  {
      first_name: "Anatoly",
      second_name: "Teseyko"
    }
  },
  user_2: {
    email: "macbeth3@qulix.com",
    password:              "swseuz2U",
    password_confirmation: "swseuz2U",
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    user_profile_attributes:  {
      first_name: "Macbeth",
      second_name: "III"
    }
  }
}

User.create!(params[:me])
User.create!(params[:user_1])
User.create!(params[:user_2])

users = User.order(:created_at).take(3)
12.times do
  content = '#tag ' + Faker::Lorem.sentence(12)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..3]
followers = users[1..3]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
