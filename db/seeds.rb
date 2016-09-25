Binary.destroy_all
User.destroy_all

@userA = User.create({
  username: "asdf", active: true, password: "asdf"
})

@userB = User.create({
  username: "test", active: true, password: "test"
})

[@userA, @userB].each do |user|
  5.times do
    user.binaries.create({
      active: true,
      name: Faker::Hipster.word,
      content: Faker::Hipster.sentence,
      votesA: 1,
      votesB: 1,
      choiceA: Faker::Hipster.word,
      choiceB: Faker::Hipster.word,
      username: user.username,
      expiration: Time.now.to_i + Faker::Number.between(3600, 90000)
      })
  end
end
puts "Created #{User.count} users and #{Binary.count} binaries"
