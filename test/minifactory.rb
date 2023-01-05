class UserFactory
  def self.user(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email_address: Faker::Internet.safe_email
  )
    User.create!(first_name:, last_name:, email_address:)
  end

  def self.user_no_deathmatches
    User.where("id not in (select user_id from deathmatches)").take || user
  end
end

class SubmissionFactory
  def self.submission(
    gpt_model: "davinci",
    gpt_prompt: Faker::Lorem.sentence(word_count: rand(3..6)),
    gpt_response: Faker::Lorem.sentence(word_count: rand(3..10)),
    response_raw: "blahblahblah",
    user: UserFactory.user
  )
    Submission.create!(gpt_model:, gpt_prompt:, gpt_response:, response_raw:, user:)
  end
end

class DeathmatchFactory
  def self.deathmatch(user: UserFactory.user)
    Deathmatch.create!(user:)
  end

  def self.deathmatch_with_submissions
    dm = deathmatch
    2.times do
      DeathmatchSubmission.create(deathmatch: dm, submission: SubmissionFactory.submission)
    end
    dm
  end
end

# class DeathmatchSubmissionFactory
#   def self.deathmatch_submission(

#   )

#   end
# end