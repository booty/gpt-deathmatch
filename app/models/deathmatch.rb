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

  # finds or creates a deathmatch for the current user to
  # vote upon
  def self.for(user:, debug: false)
    # does the user have an existing deathmatch upon which
    # they haven't voted?
    current = current_deathmatch_for(user:)
    return current if current

    # find two submissions that:
    #   this user hasn't voted on yet
    #   this user didn't create
    submissions = unvoted_submissions_for(user:, debug: debug)
    binding.pry if debug

    # if none, find two submissions that this user didn't create
    # TODO: find a combination that doesn't actually exist yet
    if submissions.length < SUBMISSIONS_PER_DEATHMATCH
      binding.pry if debug
      submissions += Submission.
        where.
        not(user:).
        order("random()").
        limit(SUBMISSIONS_PER_DEATHMATCH)
    end
    binding.pry if debug

    # well, we tried
    return nil if submissions.length < SUBMISSIONS_PER_DEATHMATCH

    deathmatch = Deathmatch.create!(user:)
    binding.pry if debug
    submissions.take(SUBMISSIONS_PER_DEATHMATCH).each do |submission|
      DeathmatchSubmission.create!(
        deathmatch:,
        submission:,
      )
    end
    deathmatch
  end

  def self.find_unique_combinations(current_submission_id_pairs:, all_submission_ids:)
    # create a set of sets representing all current pairs
    current_sets = current_submission_id_pairs.to_set(&:to_set)

    # create a set of sets representing all possible pairs
    all_sets = all_submission_ids.
      combination(SUBMISSIONS_PER_DEATHMATCH).
      to_set(&:to_set)

    # return one at random
    (all_sets - current_sets).map { |x| x.to_a.sort }
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
  def self.unvoted_submissions_for(user:, debug: false)
    sql = <<~SQL
      select
        s.*
      from
        submissions s
      where
        s.user_id <> #{user.id}
        and s.id not in (
          select
            dms.submission_id
          from
            deathmatches dm
              inner join deathmatch_submissions dms on dm.id = dms.deathmatch_id
          where
            dm.user_id = #{user.id}
        )
      order by
        random()
      limit #{SUBMISSIONS_PER_DEATHMATCH}
    SQL

    binding.pry if debug
    Submission.find_by_sql(sql)
  end
end
