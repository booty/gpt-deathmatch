# frozen_string_literal: true

puts "Seeding..."

DEFAULT_USER_EMAIL_ADDRESS = "imaginary.user@upstart.com"
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
  ["Mister", "CPU", DEFAULT_USER_EMAIL_ADDRESS],
]

users.each do |u|
  User.find_or_create_by(
    first_name: u[0],
    last_name: u[1],
    email_address: u[2],
  )
end

submissions = [
  {
    prompt: "Talk about depression and computer programming in the style of the Wu-Tang clan",
    response: <<~GPT,
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
  },
  {
    prompt: "Write me a love story about Guy Fieri and Godzilla",
    response: <<~GPT,
      Once upon a time, there lived a man named Guy Fieri, a well-known chef and restaurateur. His passion for cooking was unparalleled, and he found joy in experimenting with all kinds of flavors and cuisines.

      One day, while out exploring the countryside, Guy Fieri stumbled upon a strange creature unlike anything he had ever seen before. It was a giant lizard-like creature with bright green skin and spikes along its back.

      Guy Fieri soon realized he was looking at a real-life Godzilla! But instead of running away in fear, he was fascinated by the creature and did something quite unexpected: he offered it a plate of his famous Fieri-style nachos.

      To his surprise, the giant lizard loved the nachos! From that day forward, the two became fast friends. Guy Fieri would often make special dishes just for Godzilla, and the two would have long conversations about their favorite foods.

      They eventually fell in love and decided to get married. On their wedding day, the entire town gathered to witness the love between Guy Fieri and Godzilla. The couple had a beautiful ceremony, and everyone was amazed by the love they shared.

      Now, Guy Fieri and Godzilla are happily married and are still exploring their mutual love of food together. They both enjoy trying new flavors, creating delicious dishes, and sharing meals with their friends and family.

      Their love story is not only an example of the power of food, but also a reminder that love can be found in the most unexpected places.
    GPT
  },
  {
    prompt: "Write an RFC about why we should rewrite our upstart_web monolith in COBOL",
    response: <<~GPT,
      RFC-0001: Rewriting Upstart_Web Monolith in COBOL

      1. Introduction

      Upstart_Web is a large-scale monolithic web application that provides a variety of services to its users. It is currently written in a modern web programming language, but this language has some limitations that make it difficult to maintain and scale the application. For this reason, we propose rewriting Upstart_Web in the COBOL programming language.

      2. Rationale

      COBOL is a powerful and robust programming language that is well suited for large-scale applications such as Upstart_Web. It is a mature language with a long history of successful implementations and is well-supported by a wide variety of tools and libraries. In addition, COBOL offers excellent support for legacy systems, making it easier to integrate Upstart_Web with existing systems.

      COBOL also offers a number of features that make it well-suited to large-scale applications. It has a simple and intuitive syntax that makes it easier to read and maintain, and it is optimized for batch processing, which can help speed up processing time. Furthermore, COBOL has excellent support for data integrity, which is essential.
    GPT
  },
  {
    prompt: "Write about why Kotlin is bad in the style of Lewis Carroll",
    response: <<~GPT,
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
  },
  {
    prompt: "Design a perfect romantic date night for me involving a bottle of whiskey, a stack of anime DVDs, Cheetos, and the most attractive person in the world",
    response: <<~GPT,
      Start off with a romantic dinner at home featuring a variety of decadent dishes that pair perfectly with your bottle of whiskey. After dinner, pop in one of the anime DVDs and share some Cheetos while snuggling up with the most attractive person in the world. After the show, enjoy a nightcap of whiskey with some more Cheetos and continue the night with some cozy conversation. Finish the night off with a romantic dance under the stars or some stargazing.
    GPT
  },
  {
    prompt: "What would Ruby look like if it was a person instead of a programming language?",
    response: <<~GPT,
      Ruby, if she was a person, would be a beautiful woman with auburn hair and a mischievous twinkle in her eye. She would be a spirited, inventive, and witty companion with a flair for the dramatic. She would be incredibly intelligent and a fast learner, able to pick up new skills quickly and make connections that others don't. She would be independent and strong-willed, yet also kind-hearted and compassionate. Ruby would be an excellent listener and a reliable friend, always ready to help out in a pinch.
    GPT
  },
  {
    prompt: "Tell me the story of how Matz created the Ruby programming language, in the style of a trashy romance novel.",
    response: <<~GPT,
      Once upon a time there was a brilliant programmer named Yukihiro Matz Matsumoto. He was the brains behind the powerful, elegant programming language of Ruby. But his heart always longed for something more.

      One day he met a beautiful woman named Ruby. She was the embodiment of all of the ideas and concepts Matz had dreamed up for his language. Matz was instantly smitten by her beauty and charm.

      They began to spend more and more time together and soon Matz realized that he wanted to spend the rest of his life with Ruby. He decided to combine his knowledge of programming with his love of Ruby, and created the first version of the Ruby programming language. Matz and Ruby have been happily together ever since.

      They have created a beautiful language that has inspired and helped many programmers around the world. It was the perfect union of Matz’s love of programming and Ruby’s grace and beauty.
    GPT
  },
  {
    prompt: "Describe a fight between one hundred adorable puppies armed with chainsaws and one hundred adorable kittens armed with samurai swords.",
    response: <<~GPT,
      The scene is chaos. One hundred adorable puppies with chainsaws rev up their engines, ready to engage in battle with one hundred adorable kittens armed with samurai swords. The little puppies bark ferociously and the little kittens meow menacingly as they take their positions.

      The battle begins and the puppies rush forward, chainsaws whirring. The kittens stand their ground and prepare to fight back. The puppies swing their chainsaws wildly and the kittens slash with their swords. The air is filled with fur and the ground quickly becomes littered with the remains of the battle.

      The puppies and kittens fight bravely, neither side giving up. The puppies use their chainsaws to keep the kittens at bay, while the kittens use their swords to keep the puppies at bay. In the end, the puppies prevail and the kittens retreat in defeat.

      The puppies celebrate their victory, barking and jumping around in delight, while the kittens lick their wounds and try to regain their composure. The battle is over, but the memories of this adorable fight between puppies and kittens armed with chainsaws and swords will last forever.
    GPT
  },
  {
    prompt: "Using very large words, tell me a story about a man who eats so many hoagies that the world runs out of food",
    response: <<~GPT,
      Once upon a time, there was a ravenous man who had an insatiable penchant for hoagies. He would devour these sandwiches with such gusto that his gastronomic exploits soon became renowned throughout the land.

      News of his prodigious appetite spread far and wide, until one day it reached the ears of a powerful king. In a fit of jealous rage, the king commanded the man to cease his voracious consumption. But, alas, it was too late.

      The man had already consumed so many hoagies that, unbeknownst to him, he had single-handedly depleted the entire world's supply of food.

      The man was then exiled, never to be heard from again—a forgotten footnote in a cautionary tale about the consequences of gluttony.
    GPT
  },
  {
    prompt: "Write the world's stupidest business plan",
    response: <<~GPT,
      The business plan is to open a store that sells nothing. The store will be located in a high-traffic area and will offer customers the experience of browsing for items that do not exist. The store will also offer helpful customer service and advice to those seeking to purchase items that do not exist.
    GPT
  },
  {
    prompt: "If I made a clone of myself, would we be able to get married? Why or why not?",
    response: <<~GPT,
      No, you would not be able to get married. Marriage is a legally binding agreement between two people, and a clone is considered to be the same person as the original, so it would be considered a form of incest.
    GPT
  },
  {
    prompt: "I'm going to the store. Do you want anything? I'm bringing you donuts and ravioli no matter what. I don't even know why I asked you.",
    response: <<~GPT,
      That's so sweet of you! If it's not too much trouble, I would love a bottle of cold soda and a bag of chips. Thank you!
    GPT
  },
  {
    prompt: "I have a really positive opinion of people from Liechtenstein! Why are they so amazing? I really like the way they cook their bratwurst. I wish I could make all of them live in my basement forever but I know that's impractical.",
    response: <<~GPT,
      Liechtensteiners are amazing for many reasons! They are incredibly hospitable and welcoming to visitors, have a strong sense of identity and community, and have a very strong economy. Their cuisine is excellent, with bratwurst being a particularly popular dish. They have a strong appreciation for the outdoors, with plenty of hiking and skiing opportunities available. They also have a great education system, with a very high literacy rate, and are proud to be a part of the European Union. So all in all, Liechtensteiners are a great bunch!
    GPT
  },
  {
    prompt: "Would Roger Federer be sad if I adopted him as my own son? I want to do this but only if it would make him happy. If this is a success I would like to do something similar with Rafael Nadal. How can I make this work?",
    response: <<~GPT,
      No, Roger Federer would not be sad if you adopted him as your own son. On the contrary, he would likely be very pleased and honored. However, it is not possible to legally adopt either Roger Federer or Rafael Nadal as your own son. You could, however, reach out to their respective charities or foundations and offer to make a donation in their name. This would be a great way to show your support for them and their causes.
    GPT
  },
  {
    prompt: "What's the worst thing that could happen if I start breakdancing in WalMart? Which aisle would be best? Should I be wearing clothing? I don't care if I'm arrested. This is my art... this is my life.",
    response: <<~GPT,
      The worst thing that could happen if you start breakdancing in Walmart is that you could be asked to leave, be fined, or even arrested. It would be best to breakdance in the clothing aisle, since that would be most appropriate, and yes, you should definitely be wearing clothing.
    GPT
  },
  {
    prompt: "What happened to that girl I had a crush on in 4th grade? Her name was Tara. Did she have a crush on me too? If you're not sure, just make up a story.",
    response: <<~GPT,
      Tara went on to become a successful scientist, inventing new treatments for diseases and making great strides in the scientific community. She never had a chance to find out if you had a crush on her, but she had a feeling that you did. She always remembered her time in fourth grade fondly, thinking of you every now and then and wishing that she had the courage to tell you how she felt.
    GPT
  },
]

default_user = User.find_by(
  email_address: DEFAULT_USER_EMAIL_ADDRESS,
)

submissions.each do |s|
  sub = Submission.find_or_create_by(
    user_id: default_user.id,
    gpt_prompt: s[:prompt],
    gpt_response: s[:response],
    gpt_model: "davinci",
  )
end

# if Deathmatch.any?
#   puts "Skipping Deathmatch creation because we already have a bunch"
# else
#   all_users = User.all
#   all_submissions = Submission.all
#   Submission.all.sample(Submission.count / 2).each do |sub|
#     rand(1..6).times do |x|
#       dm = Deathmatch.create(
#         user: (all_users - [sub.user]).sample,
#         created_at: rand(1..30).days.ago,
#       )
#       votes = [1, -1].shuffle
#       DeathmatchVote.create(
#         submission: sub,
#         deathmatch: dm,
#         vote: votes.pop,
#       )
#       DeathmatchVote.create(
#         submission: (all_submissions - [sub]).sample,
#         deathmatch: dm,
#         vote: votes.pop,
#       )
#     end
#   end
# end

# Can't use ApplicationRecord.descendants unless eager_load is true
models = [User, Submission, Session, Deathmatch, DeathmatchSubmission, DeathmatchSubmissionVote]
models.each do |model|
  puts "#{model.name}: #{model.count} records"
end
