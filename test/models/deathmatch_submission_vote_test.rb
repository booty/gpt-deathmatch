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
require "test_helper"

class DeathmatchSubmissionVoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
