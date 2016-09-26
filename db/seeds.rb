Vote.destroy_all
Binary.destroy_all
User.destroy_all

@user = User.create({
  username: "Noah the First", active: true, password: "andthatisbeautiful"
})

@user.binaries.create({
  active: true,
  name: "Will this app be a success?",
  content: "Will this app get 100 downloads in its first year of existence?",
  votesA: 1,
  votesB: 1,
  choiceA: "YES",
  choiceB: "NO",
  username: @user.username,
  expiration: Time.now.to_i + 1.year.to_i
})

puts "Created #{User.count} users and #{Binary.count} binaries"
