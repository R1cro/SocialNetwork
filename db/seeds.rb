# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: "ateseyko@qulix.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

User.create!(email: "teseyko@outlook.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

User.create!(email: "r1cro@qulix.com",
            password:              "swseuz2U",
            password_confirmation: "swseuz2U",
            activated: true,
            activated_at: Time.zone.now,
            admin: false)
User.create!(email: "bill@qulix.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: false)
User.create!(email: "johne@qulix.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: false)
530.times do |n|
  email = "user-#{n+1}@mail.com"
  password = "12345678"
  User.create!(email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(530)
30.times do
  content = Faker::Lorem.sentence(35)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..1000]
followers = users[300..600]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
