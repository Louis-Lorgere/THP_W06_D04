# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Like.destroy_all
Comment.destroy_all
PrivateMessageRecipientJoin.destroy_all
PrivateMessage.destroy_all
GossipTagJoin.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all


10.times do
  City.create(name: Faker::Address.city)
end

10.times do
  Tag.create(name: Faker::Lorem.word )
end

10.times do
  User.create(name: Faker::Name.first_name, city: City.all.sample(1)[0], password: Faker::Lorem.characters(number: rand(6..13)))
end

20.times do
  Gossip.create(title: Faker::Lorem.word, content: Faker::Lorem.paragraph(sentence_count: 2), user: User.all.sample(1).first)
end

Gossip.all.each do |current|
  rand(1..3).times do
    GossipTagJoin.create(gossip: current, tag: Tag.all.sample(1).first)
  end
end

20.times do
 PrivateMessage.create(content: Faker::Lorem.paragraph(sentence_count: 2), sender: User.all.sample(1).first)
end

PrivateMessage.all.each do |current_pm|
  User.all.reject{|current_user| current_user == current_pm.sender}.sample(rand(1..9)).each do |current_recipient|
    PrivateMessageRecipientJoin.create(private_message: current_pm, recipient: current_recipient)
  end
end

20.times do
  comment = Comment.new(content: Faker::Lorem.paragraph(sentence_count: 2), user: User.all.sample(1).first)
  comment.commentable = Gossip.all.sample(1).first
  comment.save
end

20.times do
  comment = Comment.new(content: Faker::Lorem.paragraph(sentence_count: 1), user: User.all.sample(1).first)
  comment.commentable = Comment.all.sample(1).first
  comment.save
end

20.times do
  Like.create(user: User.all.sample(1).first, likeable: Gossip.all.sample(1).first)
end

20.times do
  Like.create(user: User.all.sample(1).first, likeable: Comment.all.sample(1).first)
end
