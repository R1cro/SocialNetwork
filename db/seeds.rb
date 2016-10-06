# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

# User.create!(email: "r1cro.solution@outlook.com",
#              password:              "swseuz2U",
#              password_confirmation: "swseuz2U",
#              first_name: "Anatoly",
#              second_name: "Teseyko",
#              activated: true,
#              activated_at: Time.zone.now,
#              admin: true)
#
# User.create!(email: "r1cro@qulix.com",
#             password:              "swseuz2U",
#             password_confirmation: "swseuz2U",
#             first_name: "Anatoly",
#             second_name: "Teseyko",
#             activated: true,
#             activated_at: Time.zone.now,
#             admin: false)
# User.create!(email: "bill@qulix.com",
#              password:              "swseuz2U",
#              password_confirmation: "swseuz2U",
#              first_name: "Bill",
#              second_name: "Gates",
#              activated: true,
#              activated_at: Time.zone.now,
#              admin: false)
# User.create!(email: "johne-interseptor@mail.com",
#              password:              "swseuz2U",
#              password_confirmation: "swseuz2U",
#              first_name: "John",
#              second_name: "Envy",
#              activated: true,
#              activated_at: Time.zone.now,
#              admin: false)
# 130.times do |n|
#   email = "user-#{n+1}@mail.com"
#   first_name = "User-#{n+1}"
#   password = "12345678"
#   User.create!(email: email,
#                password:              password,
#                password_confirmation: password,
#                first_name: first_name,
#                second_name: "UserS",
#                activated: true,
#                activated_at: Time.zone.now)
# end
#
