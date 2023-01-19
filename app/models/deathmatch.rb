# frozen_string_literal: true

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
  class NoDeathmatchesForYou < StandardError; end

  SUBMISSIONS_PER_DEATHMATCH = 2

  belongs_to :user
  has_many :deathmatch_submissions, dependent: :destroy
  has_many :submissions, through: :deathmatch_submissions

  def self.for(user:)
    # does the user have an existing deathmatch upon which
    # they haven't voted?

    # find two submissions that:
    #   this user hasn't voted on yet
    #   this user didn't create

    # if none, find two submissions that this user didn't create

    # if all else fails, raise an error
  end

  # Returns the newest deathmatch for this user that has no votes
  # Will return nil if none exist
  def self.current_deathmatch_for(user:)
    sql = <<~SQL
      select
        dm.*
      from
        deathmatches dm
          inner join deathmatch_submissions dms on
            dm.id = dms.deathmatch_id
      where
        dm.user_id = #{user.id}
        and dms.vote is null
      order by
        dm.id desc
    SQL

    find_by_sql(sql).first
  end

  # Returns 0-SUBMISSIONS_PER_DEATHMATCH submissions from other users
  # upon which this user has not voted
  def self.unvoted_submissions_for(user:)
    sql = <<~SQL
      select
        s.*
      from
        submissions s
      where
        s.user_id <> #{user.id}
        and s.id not in (select submission_id from deathmatch_submissions where user_id = #{user.id})
      order by
        random()
      limit #{SUBMISSIONS_PER_DEATHMATCH}
    SQL

    Submission.find_by_sql(sql)
  end
end
