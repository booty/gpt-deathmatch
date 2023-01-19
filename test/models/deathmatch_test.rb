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

  class UnvotedSubmissionsFor < DeathmatchTest
    test "doesn't return user's own submissions" do
      user1 = UserFactory.user
      user1_sub1 = SubmissionFactory.submission(user: user1)
      user1_sub2 = SubmissionFactory.submission(user: user1)
      user2_sub1 = SubmissionFactory.submission
      user3_sub1 = SubmissionFactory.submission

      result = Deathmatch.unvoted_submissions_for(user: user1)

      assert_includes(result, user2_sub1, "Result should contain user2_sub1")
      assert_includes(result, user3_sub1, "Result should contain user3_sub1")
      assert_equal(2, result.length, "Result should have 2 items")
    end

    test "returns nothing when user has voted upon everything already" do
      user1 = UserFactory.user
      DeathmatchFactory.deathmatch_with_submissions_and_votes(
        user: user1,
      )

      assert_empty(
        Deathmatch.unvoted_submissions_for(user: user1),
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
        [other_persons_sub],
        Deathmatch.unvoted_submissions_for(user: user1),
      )
    end

    test "returns the correct two submissions when others have voted upon them" do
      user1 = UserFactory.user
      dm = DeathmatchFactory.deathmatch_with_submissions_and_votes

      assert_equal(
        Deathmatch.unvoted_submissions_for(user: user1).sort,
        dm.submissions.sort,
      )
    end
  end
end
