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
require "test_helper"

class DeathmatchTest < ActiveSupport::TestCase
  class CurrentDeathmatchForTest < DeathmatchTest
    test "returns the correct current deathmatch in a simple case with no votes" do
      dm1 = DeathmatchFactory.deathmatch_with_submissions
      dm2 = DeathmatchFactory.deathmatch_with_submissions
      dm3 = DeathmatchFactory.deathmatch_with_submissions(user: dm1.user)

      assert_equal(
        dm3,
        Deathmatch.current_deathmatch_for(user: dm1.user),
        "Should pick the newer of (dm1, dm3) which both belong to this user",
      )

      assert_equal(
        dm2,
        Deathmatch.current_deathmatch_for(user: dm2.user),
        "Should pick dm2, the only one that belongs to this user",
      )

      assert_nil(
        Deathmatch.current_deathmatch_for(user: UserFactory.user),
        "Should return nil because this user has no deathmatches",
      )
    end

    test "returns the correct current deathmatch when we have votes for the other one" do
      user1_dm1 = DeathmatchFactory.deathmatch_with_submissions
      user1_dm2 = DeathmatchFactory.deathmatch_with_submissions_and_votes(user: user1_dm1.user)
      user2_dm1 = DeathmatchFactory.deathmatch_with_submissions_and_votes

      # s/b dm1 because it's the newest one with no votes
      # shouldn't pick user1_dm2 because it has votes
      # shouldn't pick user2_dm1 because it belongs to somebody else
      assert_equal(
        user1_dm1,
        Deathmatch.current_deathmatch_for(
          user: user1_dm1.user,
        ),
        "should be user1_dm1",
      )

      # s/b nil because they have one deathmatch and they voted for it
      assert_nil(Deathmatch.current_deathmatch_for(user: user2_dm1.user))
    end
  end

  class UnvotedSubmissionsForTest < DeathmatchTest
    test "doesn't return user's own submissions" do
      user1 = UserFactory.user
      user1_sub1 = SubmissionFactory.submission(user: user1)
      user1_sub2 = SubmissionFactory.submission(user: user1)
      user2_sub1 = SubmissionFactory.submission
      user3_sub1 = SubmissionFactory.submission

      result = Deathmatch.unvoted_submission_ids_for(user: user1)

      assert_includes(result, user2_sub1.id, "Result should contain user2_sub1")
      assert_includes(result, user3_sub1.id, "Result should contain user3_sub1")
      assert_equal(2, result.length, "Result should have 2 items")
    end

    test "returns nothing when user has voted upon everything already" do
      user1 = UserFactory.user
      DeathmatchFactory.deathmatch_with_submissions_and_votes(
        user: user1,
      )

      assert_empty(
        Deathmatch.unvoted_submission_ids_for(user: user1),
        "User already voted on everything",
      )
    end

    test "returns one submission when it's the only unvoted one" do
      user1 = UserFactory.user
      DeathmatchFactory.deathmatch_with_submissions_and_votes(
        user: user1,
      )
      other_persons_sub = SubmissionFactory.submission

      assert_equal(
        [other_persons_sub.id],
        Deathmatch.unvoted_submission_ids_for(user: user1),
      )
    end

    test "returns the correct two submissions when others have voted upon them" do
      user1 = UserFactory.user
      dm = DeathmatchFactory.deathmatch_with_submissions_and_votes

      assert(
        dm.submissions.map(&:id).same_elements_as?(
          Deathmatch.unvoted_submission_ids_for(user: user1),
        ),
      )
    end
  end

  class FindUniqueCombinationsTest < DeathmatchTest
    test "returns nil when there's nothing" do
      assert_empty(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [],
          all_eligible_submission_ids: [],
        ),
      )
    end

    test "returns nil when there's one thing and it ain't unique" do
      assert_empty(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [[2, 1]],
          all_eligible_submission_ids: [1, 2],
        ),
      )
    end

    test "returns nil when there's several but they're not unique" do
      assert_empty(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [[2, 1], [4, 3], [1, 4], [2, 3], [4, 2], [1, 3]],
          all_eligible_submission_ids: [4, 2, 1, 3],
        ),
      )
    end

    test "returns nil when there's 3 but two aren't unique" do
      assert_empty(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [[1, 2], [2, 3], [3, 1]],
          all_eligible_submission_ids: [1, 2, 3],
        ),
      )
    end

    test "returns the only possible pair" do
      assert_equal(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [],
          all_eligible_submission_ids: [1, 2],
        ).to_set,
        Set.new([[1, 2]]),
      )
    end

    test "returns all possible pairs when I have none" do
      assert_equal(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [],
          all_eligible_submission_ids: [1, 2, 3],
        ).to_set,
        Set.new([[1, 2], [2, 3], [1, 3]]),
      )
    end

    test "returns all possible pairs when I have some" do
      assert_equal(
        Deathmatch.find_unique_combinations(
          current_submission_id_pairs: [[2, 3]],
          all_eligible_submission_ids: [1, 2, 3],
        ).to_set,
        Set.new([[1, 2], [1, 3]]),
      )
    end
  end

  class FindOrCreateForTest < DeathmatchTest
    test "returns nothing when there's nothing" do
      assert_nil(Deathmatch.find_or_create_for(user: UserFactory.user))
    end

    test "returns nothing when there's nothing except this user's subs" do
      user = UserFactory.user
      2.times { SubmissionFactory.submission(user:) }
      assert_nil(Deathmatch.find_or_create_for(user:))
    end

    test "idempotently returns a dm with correct subs" do
      user = UserFactory.user
      2.times { SubmissionFactory.submission(user:) }
      sub1 = SubmissionFactory.submission
      sub2 = SubmissionFactory.submission

      dm1 = Deathmatch.find_or_create_for(user:)
      dm2 = Deathmatch.find_or_create_for(user:)

      assert_equal(
        dm1,
        dm2,
        "shouldn't create a new deathmatch; user hasn't voted on the first one yet",
      )
      assert_equal(
        [sub1, sub2],
        dm1.submissions.sort,
        "returns deathmatch with correct subs the first time",
      )
      assert_equal(
        [sub1, sub2],
        dm2.submissions.sort,
        "returns deathmatch with correct subs the second time",
      )
    end

    test "returns a new dm after user voted on the first one" do
      user1 = UserFactory.user
      user2 = UserFactory.user
      sub1 = SubmissionFactory.submission
      sub2 = SubmissionFactory.submission

      user1_dm1 = Deathmatch.find_or_create_for(user: user1)
      user1_dm1.deathmatch_submissions.first.update!({ vote: 1 })
      user1_dm1.deathmatch_submissions.last.update!({ vote: -1 })

      assert_nil(
        Deathmatch.find_or_create_for(user: user1),
        "nothing for user1 to vote on; already voted",
      )

      user2_dm1 = Deathmatch.find_or_create_for(user: user2)

      assert(
        [sub1, sub2].same_elements_as?(user2_dm1.submissions),
        "user2 should get a dm with sub1+sub2",
      )

      sub3 = SubmissionFactory.submission
      sub4 = SubmissionFactory.submission
      user1_dm2 = Deathmatch.find_or_create_for(user: user1)

      assert(
        [sub3, sub4].same_elements_as?(user1_dm2.submissions),
        "user1 should get a new dm with sub3+sub4",
      )
    end

    test "returns a dm with one sub the user never voted on, plus one other" do
      user = UserFactory.user

      # After this, we'll have three submissions.
      # User has voted on the first two.
      dm1 = DeathmatchFactory.deathmatch_with_submissions_and_votes(user:)
      other_sub = SubmissionFactory.submission

      dm2 = Deathmatch.find_or_create_for(user:)
      dm2_subs = dm2.submissions

      assert(
        dm2.submissions.same_elements_as?([other_sub, dm1.submissions.first]) ||
        dm2.submissions.same_elements_as?([other_sub, dm1.submissions.last]),
      )
    end

    test "returns nothing if the user voted on everything" do
      user = UserFactory.user

      DeathmatchFactory.deathmatch_with_submissions_and_votes(user:)

      assert_nil(Deathmatch.find_or_create_for(user:))
    end

    test "prefer submissions upon which the user has never voted" do
      user = UserFactory.user

      DeathmatchFactory.deathmatch_with_submissions_and_votes(user:)
      sub3 = SubmissionFactory.submission
      sub4 = SubmissionFactory.submission

      assert(
        [sub3, sub4].same_elements_as?(
          Deathmatch.find_or_create_for(user:).submissions,
        ),
      )
    end
  end
end
