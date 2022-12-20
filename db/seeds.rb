# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


users = [
  %w{John Rose john.rose@upstart.com},
  %w{James Felton james.felton@upstart.com},
  %w{Nate Caldwell nathaniel.caldwell@upstart.com},
  %w{Jake Hayes jake.hayes@upstart.com},
  %w{Jon Norstrom jon.norstrom@upstart.com},
  %w{Caroline Ibbotson caroline.ibbotson@upstart.com},
  %w{Michael Miller michael.miller@upstart.com},
  %w{Casey Merkey casey.merkey@upstart.com},
  %w{Tony Santucci tony.santucci@upstart.com},
  %w{Alex Holmes alex.holmes@upstart.com},
  %w{Mister CPU imaginary.user@upstart.com}
]

users.each do |u|
  User.find_or_create_by(
    first_name: u[0],
    last_name: u[1],
    email_address: u[2],
  )
end

default_user = User.find_by(
  email_address: "imaginary.user@upstart.com"
)

Submission.find_or_create_by(
  user_id: default_user.id,
  prompt: "Talk about depression and computer programming in the style of the Wu-Tang clan ",
  gpt_model: "davinci",
  response_raw: '{"seed_data": true}',
  response: <<~GPT
    Verse 1
    Depression lurks like a predator, creeping in from the shadows of our minds.
    It can take away our motivation, leaving us feeling caged and confined.
    But for computer programmers with the right frame of mind, there's still hope to be found.
    Through coding and programming they can escape depression's bounds.

    Chorus
    Computer Programming is their refuge from depression's cloud! Writing code and debugging helps them keep it on the down low!

    Verse 2
    Programming is a form of art that allows creative expression,
    while combatting feelings of despair brought on by depression.
    Seeing tangible results when you finish your work gives great satisfaction and joy!
    Like Wu-Tang Clan said: "Cash rules everything around me, C.R.E.A.M., get the money!"

    Chorus
    Computer Programming is their refuge from depression's cloud! Writing code and debugging helps them keep it on the down low!
  GPT
)

Submission.find_or_create_by(
  user_id: default_user.id,
  prompt: "Write me a love story about Guy Fieri and Godzilla",
  gpt_model: "davinci",
  response_raw: '{"seed_data": true}',
  response: <<~GPT
    Once upon a time, there lived a man named Guy Fieri, a well-known chef and restaurateur. His passion for cooking was unparalleled, and he found joy in experimenting with all kinds of flavors and cuisines.

    One day, while out exploring the countryside, Guy Fieri stumbled upon a strange creature unlike anything he had ever seen before. It was a giant lizard-like creature with bright green skin and spikes along its back.

    Guy Fieri soon realized he was looking at a real-life Godzilla! But instead of running away in fear, he was fascinated by the creature and did something quite unexpected: he offered it a plate of his famous Fieri-style nachos.

    To his surprise, the giant lizard loved the nachos! From that day forward, the two became fast friends. Guy Fieri would often make special dishes just for Godzilla, and the two would have long conversations about their favorite foods.

    They eventually fell in love and decided to get married. On their wedding day, the entire town gathered to witness the love between Guy Fieri and Godzilla. The couple had a beautiful ceremony, and everyone was amazed by the love they shared.

    Now, Guy Fieri and Godzilla are happily married and are still exploring their mutual love of food together. They both enjoy trying new flavors, creating delicious dishes, and sharing meals with their friends and family.

    Their love story is not only an example of the power of food, but also a reminder that love can be found in the most unexpected places.
  GPT
)

Submission.find_or_create_by(
  user_id: default_user.id,
  prompt: "Write an RFC about why we should rewrite our upstart_web monolith in COBOL",
  gpt_model: "davinci",
  response_raw: '{"seed_data": true}',
  response: <<~GPT
    RFC-0001: Rewriting Upstart_Web Monolith in COBOL

    1. Introduction

    Upstart_Web is a large-scale monolithic web application that provides a variety of services to its users. It is currently written in a modern web programming language, but this language has some limitations that make it difficult to maintain and scale the application. For this reason, we propose rewriting Upstart_Web in the COBOL programming language.

    2. Rationale

    COBOL is a powerful and robust programming language that is well suited for large-scale applications such as Upstart_Web. It is a mature language with a long history of successful implementations and is well-supported by a wide variety of tools and libraries. In addition, COBOL offers excellent support for legacy systems, making it easier to integrate Upstart_Web with existing systems.

    COBOL also offers a number of features that make it well-suited to large-scale applications. It has a simple and intuitive syntax that makes it easier to read and maintain, and it is optimized for batch processing, which can help speed up processing time. Furthermore, COBOL has excellent support for data integrity, which is essential for mission-
  GPT
)

Submission.find_or_create_by(
  user_id: default_user.id,
  prompt: "Write about why Kotlin is bad in the style of Lewis Carroll",
  gpt_model: "davinci",
  response_raw: '{"seed_data": true}',
  response: <<~GPT
    'Twas brillig, and the Kotlin did not please,
    All slithy and strange, it did not ease.
    Its syntax was a burden, no matter how hard it tried,
    And its features a riddle, from which none could hide.

    It lacked many features, and had a steep learning curve,
    Which made it a poor choice for those who wished to serve.
    It was a slow language, and its compilation was slow,
    Which made it a nightmare for any coder to know.

    It had a lack of libraries, and almost no support,
    Which made it a dreary choice for any to resort.
    It had a lack of documentation, and was difficult to debug,
    Which made it a poor choice for any project big.

    It was a language of frustration, and of difficulty,
    Which made it a poor choice for any to use with ease.
    So if you seek a language that's easy to learn,
    Kotlin is not the one you should turn.
  GPT
)

Submission.find_or_create_by(
  user_id: default_user.id,
  prompt: "Design a perfect romantic date night for me involving a bottle of whiskey, a stack of anime DVDs, Cheetos, and the most attractive person in the world",
  gpt_model: "davinci",
  response_raw: '{"seed_data": true}',
  response: <<~GPT
    Start off with a romantic dinner at home featuring a variety of decadent dishes that pair perfectly with your bottle of whiskey. After dinner, pop in one of the anime DVDs and share some Cheetos while snuggling up with the most attractive person in the world. After the show, enjoy a nightcap of whiskey with some more Cheetos and continue the night with some cozy conversation. Finish the night off with a romantic dance under the stars or some stargazing.
  GPT
)

# Submission.find_or_create_by(
#   user_id: default_user.id,
#   prompt: "",
#   response: <<~GPT
#   GPT
#   ,
#   gpt_model: "davinci",
#   response_raw: '{"seed_data": true}',
# )


puts "There are #{User.count} users and #{Submission.count} submissions. Happy GPT'ing!"