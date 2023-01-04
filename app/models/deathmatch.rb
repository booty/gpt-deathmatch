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
  belongs_to :user
  has_many :deathmatch_votes, dependent: :destroy
  has_many :deathmatches, through: :deathmatch_votes
end
