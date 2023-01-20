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

class Deathmatch < ApplicationRecord
  SUBMISSIONS_PER_DEATHMATCH = 2

  belongs_to :user
  has_many :deathmatch_submissions, dependent: :destroy
  has_many :submissions, through: :deathmatch_submissions

  # finds or creates a deathmatch for the current user
  def self.find_or_create_for(user:, debug: false)
    # does the user have an existing deathmatch upon which
    # they haven't voted? if so, return that instead of creating
    # a new one
    current = current_deathmatch_for(user:)
    return current if current

    # find two submissions that:
    #   this user hasn't voted on yet
    #   this user didn't create
    submission_id_pairs = unvoted_submission_ids_for(user:, debug:).
      combination(SUBMISSIONS_PER_DEATHMATCH).to_a

    # if none, find two submissions that this user didn't create
    # TODO: find a combination that doesn't actually exist yet
    if submission_id_pairs.empty?
      current_submission_id_pairs = DeathmatchSubmission.
        deathmatch_submission_id_pairs_for(user:)

      submission_id_pairs += find_unique_combinations(
        current_submission_id_pairs:,
        all_eligible_submission_ids: all_eligible_submission_ids_for(user:),
        debug:,
      )
    end

    # well, we tried. guess it's not possible!
    return nil if submission_id_pairs.empty?

    # create a new deathmatch, with two randomly selected submissions
    deathmatch = Deathmatch.create!(user:)
    submission_id_pairs.sample.each do |submission_id|
      DeathmatchSubmission.create!(
        deathmatch:,
        submission: Submission.find(submission_id), # yuck but w/e
      )
    end
    deathmatch
  end

  # An array of submissions that can be considered for this user's next deathmatch
  # Currently, this is "all submissions from other users"
  def self.all_eligible_submission_ids_for(user:)
    Submission.
      where.
      not(user:).
      pluck(:id)
  end

  def self.find_unique_combinations(current_submission_id_pairs:, all_eligible_submission_ids:, debug: false)
    # create a set of sets representing all current pairs
    current_sets = current_submission_id_pairs.to_set(&:to_set)

    # create a set of sets representing all possible pairs
    all_sets = all_eligible_submission_ids.
      combination(SUBMISSIONS_PER_DEATHMATCH).
      to_set(&:to_set)

    (all_sets - current_sets).map { |x| x.to_a.sort }
  end

  # Returns the newest deathmatch for this user that has no votes
  # Will return nil if none exist.
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

    # There shouldn't be multiple results but if there are we'll take the
    # newest one
    find_by_sql(sql).first
  end

  # Returns 0-SUBMISSIONS_PER_DEATHMATCH submissions from other users
  # upon which this user has not voted
  def self.unvoted_submission_ids_for(user:, debug: false)
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

    # TODO: optimize this, we just ids, not ARec objects
    Submission.find_by_sql(sql).map(&:id)
  end
end
