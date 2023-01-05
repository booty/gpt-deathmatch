# == Schema Information
#
# Table name: deathmatches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_deathmatches_on_user_id  (user_id)
#
class Deathmatch < ApplicationRecord
  SUBMISSIONS_PER_DEATHMATCH = 2

  belongs_to :user
  has_many :deathmatch_submissions, dependent: :destroy
  has_many :deathmatch_submission_votes, through: :deathmatch_submissions
end
