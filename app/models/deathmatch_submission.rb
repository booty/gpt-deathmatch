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
class DeathmatchSubmission < ApplicationRecord
  class TooManySubmissions < StandardError; end
  class DuplicateDeathmatch < StandardError; end

  belongs_to :deathmatch
  belongs_to :submission

  validate :deathmatch_doesnt_have_too_many_submissions, on: :create
  validate :deathmatch_is_not_a_duplicate_for_this_user, on: :create
  validates :vote, inclusion: { in: [-1, 1, nil] }

  def deathmatch_doesnt_have_too_many_submissions
    # There should be at most, 1 other DeathmatchSubmission for this Deathmatch
    other_submission_count = deathmatch.deathmatch_submissions.count

    return if other_submission_count < Deathmatch::SUBMISSIONS_PER_DEATHMATCH

    raise TooManySubmissions,
      "Already have #{other_submission_count} DeathmatchSubmissions for Deathmatch #{deathmatch_id}"
  end

  def deathmatch_is_not_a_duplicate_for_this_user
    this_dm_pair = deathmatch.deathmatch_submissions.pluck(:submission_id).to_set
    this_dm_pair << submission.id
    return unless this_dm_pair.length == 2

    other_dm_pairs_for_user = self.class.deathmatch_submission_id_pairs_for(
      user: deathmatch.user.reload,
    )

    raise DuplicateDeathmatch if other_dm_pairs_for_user.include?(this_dm_pair)
  end

  def self.deathmatch_submission_id_pairs_for(user:)
    user.
      deathmatches.
      map { |dm| dm.deathmatch_submissions.pluck(:submission_id).to_set }
  end
end
