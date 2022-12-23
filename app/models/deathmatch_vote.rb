# == Schema Information
#
# Table name: deathmatch_votes
#
#  id            :integer          not null, primary key
#  vote          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deathmatch_id :integer          not null
#  submission_id :integer          not null
#
# Indexes
#
#  index_deathmatch_votes_on_deathmatch_id  (deathmatch_id)
#  index_deathmatch_votes_on_submission_id  (submission_id)
#
class DeathmatchVote < ApplicationRecord
  belongs_to :deathmatch
  belongs_to :submission
end
