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
class DeathmatchSubmission < ApplicationRecord
  belongs_to :deathmatch
  belongs_to :submission
  has_many :deathmatch_submission_votes, dependent: :destroy
end
