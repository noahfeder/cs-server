Vote.destroy_all
Binary.destroy_all
User.destroy_all

@user = User.create({
  username: "Noah the First", active: true, password: "andthatisbeautiful"
})

@user.binaries.create([
  {
    active: true,
    name: "Should I quit my day job?",
    content: "Will this app get 100 downloads in its first year of existence?",
    votesA: 1,
    votesB: 1,
    choiceA: "YES",
    choiceB: "NO",
    username: @user.username,
    expiration: Time.now.to_i + 1.year.to_i
  },
  {
    active: true,
    name: "What should I get for lunch?",
    content: "I'm too tired to decide for myself.",
    votesA: 1,
    votesB: 1,
    choiceA: "Italian",
    choiceB: "Sushi",
    username: @user.username,
    expiration: Time.now.to_i + 11.hours.to_i
  },
  {
    active: true,
    name: "ELECTION TIME",
    content: "There are two candidates, one of whom is electable. This is now the official way of deciding the US election.",
    votesA: 1,
    votesB: 1,
    choiceA: "Hillay",
    choiceB: "Chillary",
    username: @user.username,
    expiration: Time.now.to_i + 41.days.to_i
  },
  {
    active: true,
    name: "When should I sleep",
    content: "There once was a girl named Lenore\nAnd a bird and a bust and a door\nAnd a guy with depression\nAnd a whole lot of questions\nAnd the bird always says 'Nevermore.'",
    votesA: 1,
    votesB: 1,
    choiceA: "Never",
    choiceB: "Always",
    username: @user.username,
    expiration: Time.now.to_i + 1.week.to_i
  }
])

puts "Created #{User.count} users and #{Binary.count} binaries"
