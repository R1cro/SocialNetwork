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

User.create!(email: "r1cro@qulix.com",
            password:              "swseuz2U",
            password_confirmation: "swseuz2U",
            activated: true,
            activated_at: Time.zone.now,
            admin: true)
User.create!(email: "bill@qulix.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)
User.create!(email: "www@qulix.com",
             password:              "swseuz2U",
             password_confirmation: "swseuz2U",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)
10.times do |n|
  email = "user-#{n+1}@mail.com"
  password = "12345678"
  User.create!(email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(10)
10.times do
  content = Faker::Lorem.sentence(8)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..10]
followers = users[3..6]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
