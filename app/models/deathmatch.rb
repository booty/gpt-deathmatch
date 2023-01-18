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
  has_many :deathmatch_submission_votes, through: :deathmatch_submissions

  def self.for(user:)
    # does the user have an existing deathmatch upon which
    # they haven't voted?

    # find two submissions that:
    #   this user hasn't voted on yet
    #   this user didn't create

    # if none, find two submissions that this user didn't create

    # if all else fails, raise an error
  end

  def self.current_deathmatch_for(user:)
    sql = <<~SQL
      select
        dm.*
      from
        deathmatches dm
          inner join deathmatch_submissions dms on
            dm.id = dms.deathmatch_id
          left outer join deathmatch_submission_votes dmsv on
            dms.id = dmsv.deathmatch_submission_id
      where
        dm.user_id = #{user.id}
        and dmsv.id is null
      order by
        dm.id desc
    SQL

    find_by_sql(sql).first
  end

  def self.prime_candidates(user:)
    foo = Submission.find_by_sql(<<~SQL).first
      with existing_votes_by_user as (
      select
        ds.submission_id
      from
        deathmatches d
          inner join deathmatch_submissions ds on d.id = ds.deathmatch_id
          inner join deathmatch_submission_votes dsv on ds.id = dsv.deathmatch_submission_id
      where
        d.user_id = #{user.id.to_i}
      )

      select
        *
      from
        submissions s
      where
        s.id not in (select submission_id from existing_votes_by_user)
        and s.user_id <> #{user.id}
      order by
        random()
      limit #{SUBMISSIONS_PER_DEATHMATCH}
    SQL
  end
end
