# == Schema Information
#
# Table name: deathmatch_submissions
#
#  id            :integer          not null, primary key
#  vote          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deathmatch_id :integer          not null
#  submission_id :integer          not null
#
# Indexes
#
#  index_deathmatch_submissions_on_deathmatch_id                    (deathmatch_id)
#  index_deathmatch_submissions_on_deathmatch_id_and_submission_id  (deathmatch_id,submission_id) UNIQUE
#  index_deathmatch_submissions_on_submission_id                    (submission_id)
#
require "test_helper"

class DeathmatchSubmissionTest < ActiveSupport::TestCase
  test "doesn't allow > 2 submissions per deathmatch" do
    deathmatch = DeathmatchFactory.deathmatch
    submissions = Array.new(3) { SubmissionFactory.submission }

    DeathmatchSubmission.create(deathmatch:, submission: submissions.first)
    DeathmatchSubmission.create(deathmatch:, submission: submissions.second)

    assert_raises(DeathmatchSubmission::TooManySubmissions) do
      DeathmatchSubmission.create(deathmatch:, submission: submissions.last)
    end
  end

  test "doesn't allow duplicate submissions per deathmatch" do
    deathmatch = DeathmatchFactory.deathmatch
    submission = SubmissionFactory.submission

    DeathmatchSubmission.create!(deathmatch:, submission:)

    assert_raises(ActiveRecord::RecordNotUnique) do
      DeathmatchSubmission.create!(deathmatch:, submission:)
    end
  end

  test "doesn't allow duplicate deathmatches for a given user" do
    users = Array.new(2) { UserFactory.user }
    submissions = Array.new(2) { SubmissionFactory.submission }

    # make sure we're not creating false positive failures
    users.each do |user|
      deathmatch = Deathmatch.new(user:)
      DeathmatchSubmission.create(deathmatch:, submission: submissions.first)
      DeathmatchSubmission.create(deathmatch:, submission: submissions.last)
    end

    # create a duplicate deathmatch for the first user
    deathmatch = Deathmatch.new(user: users.first)
    DeathmatchSubmission.create(deathmatch:, submission: submissions.first)
    assert_raises(DeathmatchSubmission::DuplicateDeathmatch) do
      DeathmatchSubmission.create(deathmatch:, submission: submissions.last)
    end
  end
end
