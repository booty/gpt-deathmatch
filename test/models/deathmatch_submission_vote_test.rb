# == Schema Information
#
# Table name: deathmatch_submission_votes
#
#  id                       :integer          not null, primary key
#  vote                     :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  deathmatch_submission_id :integer          not null
#
# Indexes
#
#  index_deathmatch_submission_votes_on_deathmatch_submission_id  (deathmatch_submission_id) UNIQUE
#
require "test_helper"

class DeathmatchSubmissionVoteTest < ActiveSupport::TestCase
  test "don't allow multiple votes for one DeathmatchSubmission" do
    deathmatch_submission = DeathmatchFactory.
      deathmatch_with_submissions.
      deathmatch_submissions.
      first

    DeathmatchSubmissionVote.create(deathmatch_submission:, vote: 1)

    assert_raises(ActiveRecord::RecordNotUnique) do
      DeathmatchSubmissionVote.create(deathmatch_submission:, vote: 1)
    end
  end
end
