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
#  index_deathmatch_submission_votes_on_deathmatch_submission_id  (deathmatch_submission_id)
#
class DeathmatchSubmissionVote < ApplicationRecord
  class DeathmatchAlreadyHasVotes < StandardError; end
  belongs_to :deathmatch_submission
  validates :vote, inclusion: [-1, 1]
  validate :no_more_than_two_votes_per_deathmatch

  def no_more_than_two_votes_per_deathmatch
    other_votes_count = deathmatch.
      deathmatch_votes.
      where.not(id:).
      count

    return if other_votes_count < Submission::SUBMISSIONS_PER_DEATHMATCH

    raise DeathmatchAlreadyHasVotes,
      "Deathmatch #{deathmatch.id} already has #{other_votes_count} votes"
  end
end
