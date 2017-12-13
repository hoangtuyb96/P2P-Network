# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |index|
  User.create!(email: Faker::Internet.unique.email, 
    password: "12345678",
    password_confirmation: "12345678",
    fullname: Faker::Name.name, avatar: Faker::Avatar.image)
end

200.times do |index|
  Status.create!(content: Faker::OnePiece.quote,
    user_id: rand(1..10))
end

500.times do |index|
  Image.create!(status_id: rand(1..20),
    link: "image/upload/v1512838414/gugwcrp9hw5o6irxldwb.jpg")
end

500.times do |index|
  Comment.create!(commentable_id: rand(1..50), commentable_type: "Status",
    user_id: rand(1..50), content: Faker::OnePiece.akuma_no_mi)
end

10.times do |index|
  Relationship.create!(sender_id: rand(1..10), accepter_id: rand(1..10),
    status: rand(0..2))
end

10.times do |index|
  Report.create!(user_id: rand(1..10), reportable_id: rand(1..10),
    reportable_type: "User", content: Faker::Pokemon.move)
end

50.times do |index|
  Group.create!(name: Faker::Pokemon.name, about: Faker::Pokemon.location)
end

100.times do |index|
  GroupMember.create!(group_id: rand(1..20), user_id: rand(1..10),
    permission: "1")
end
