# == Schema Information
#
# Table name: deathmatch_submissions
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deathmatch_id :integer          not null
#  submission_id :integer          not null
#
# Indexes
#
#  index_deathmatch_submissions_on_deathmatch_id  (deathmatch_id)
#  index_deathmatch_submissions_on_submission_id  (submission_id)
#
require "test_helper"

class DeathmatchSubmission < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
